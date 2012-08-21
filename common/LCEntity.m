
#import "LCEntity.h"
#import "LivelyBlocks.h"
#import "LCStore.h"

@implementation LCEntity {
  NSString *_objectID;
  id <NSCoding> _object;
  LCStore *_store;
  NSMutableArray *_observers;
  dispatch_queue_t _queue;
  dispatch_queue_t _ioqueue;
}

+ (id)entityWithID:(NSUUID *)objectID store:(LCStore *)store {
  return [[self alloc] initWithID:objectID object:nil store:store];
}

+ (id)entityWithObject:(id <NSCoding>)object store:(LCStore *)store {
  return [[self alloc] initWithID:[NSUUID UUID] object:object store:store];
}

- (void)initializeQueue {
  _queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
  _ioqueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_SERIAL);
}

- (id)initWithID:(NSUUID *)anObjectID object:(id <NSCoding>)object store:(LCStore *)store {
  self = [super init];
  if (self != nil) {
    _objectID = [anObjectID UUIDString];
    _store = store;
    _observers = [NSMutableArray array];
    _object = object;
    [self initializeQueue];
    [self storeObject];
  }
  return self;
}

- (NSUUID *)objectID {
  return [[NSUUID alloc] initWithUUIDString:_objectID];
}

- (void)addObserver:(id <LCEntityObserver>)observer {
  dispatch_sync(_queue, ^{
    [_observers addObject:observer];
    if (_observers.count == 1) {
      [_store subscribeToKey:_objectID observer:self];
    }
  });
}

- (void)removeObserver:(id <LCEntityObserver>)observer {
  dispatch_sync(_queue, ^{
    [_observers removeObject:observer];
    if ([_observers count] == 0) {
      [_store unsubscribeFromKey:_objectID observer:self];
    }
  });
}

- (void)emitUpdateEvent {
  dispatch_sync(_queue, ^{
    [_observers forEach:^(id <LCEntityObserver> each) {
      [each updatedEntity:self];
    }];
  });
}

- (void)emitDeleteEvent {
  dispatch_sync(_queue, ^{
    [_observers forEach:^(id <LCEntityObserver> each) {
      [each deletedEntity:self];
    }];
  });
}

- (NSData *)serialize:(id <NSCoding>)object {
  return [NSKeyedArchiver archivedDataWithRootObject:object];
}

- (id)deserialize:(NSData *)data {
  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  unarchiver.delegate = self;
  id object = [unarchiver decodeObjectForKey:@"root"];
  [unarchiver finishDecoding];
  return object;
}

- (void)uncacheObject {
  dispatch_sync(_ioqueue, ^{
    _object = nil;    
  });
}

LCEntityReadHandler readHandlerWrapper(LCEntityReadHandler handler) {
  dispatch_queue_t currentQueue = dispatch_get_current_queue();
  return ^(id object) {
    dispatch_async(currentQueue, ^{
      handler(object);
    });
  };
};

- (void)readObject:(LCEntityReadHandler)handler {
  LCEntityReadHandler handlerWrapped = readHandlerWrapper(handler);
  dispatch_async(_ioqueue, ^{
    if (_object) {
      handlerWrapped(_object);
    } else {
      [_store dataForKey:_objectID handler:^(NSData *data) {
        _object = [self deserialize:data];
        handlerWrapped(_object);
      }];
    }
  });
}

- (void)storeObject {
  dispatch_async(_ioqueue, ^{
    if (_object) {
      NSData *data = [self serialize:_object];
      [_store updateData:data forKey:_objectID];
    }
  });
}

LCEntityUpdateHandler updateHandlerWrapper(LCEntityUpdateHandler handler) {
  dispatch_queue_t currentQueue = dispatch_get_current_queue();
  return ^(id object, LCDoneHandler done) {
    dispatch_async(currentQueue, ^{
      handler(object, done);
    });
  };
}

- (void)updateObject:(LCEntityUpdateHandler)handler {
  LCEntityUpdateHandler callbackWrapped = updateHandlerWrapper(handler);
  dispatch_async(_ioqueue, ^{
    [self readObject:^(id object) {
      callbackWrapped([object copy], ^(id updatedObject) {
        dispatch_async(_ioqueue, ^{
          _object = updatedObject;
          [self storeObject];
        });
      });
    }];
  });
}

- (void)deleteObject {
  [_store deleteDataForKey:_objectID];
}

/*
 LCDataObserver protocol
*/

- (void)updated:(NSString *)key {
  [self uncacheObject];
  [self emitUpdateEvent];
}

- (void)deleted:(NSString *)key {
  [self uncacheObject];
  [self emitDeleteEvent];
}

/*
 NSCoding protocol
*/

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    _objectID = [aDecoder decodeObjectForKey:@"objectID"];
    [self initializeQueue];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_objectID forKey:@"objectID"];
}

/*
 NSUnarchiver delegate protocol
*/

- (void)setStore:(LCStore *)store {
  _store = store;
}

- (id)unarchiver:(NSKeyedUnarchiver *)unarchiver didDecodeObject:(id)object {
  if([object isKindOfClass:[LCEntity class]]) {
    [object setStore:_store];
  }
  return object;
}

@end

@implementation LCEntityEvents

- (void)updatedEntity:(LCEntity *)entity {
  [self emitEvent:@"updated" withMessage:nil];
}

- (void)deletedEntity:(LCEntity *)entity {
  [self emitEvent:@"deleted" withMessage:nil];
}

- (void)onUpdate:(LCNotifyBlock)handler {
  [self registerEvent:@"updated" withHandler:^(id message) {
    handler();
  }];
}

- (void)onDelete:(LCNotifyBlock)handler {
  [self registerEvent:@"deleted" withHandler:^(id message) {
    handler();
  }];
}

@end
