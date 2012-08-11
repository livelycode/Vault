
#import "LCEntity.h"
#import "LivelyBlocks.h"
#import "LCStore.h"

@implementation LCEntity {
  NSString *_objectID;
  id <NSCoding> _object;
  LCStore *_store;
  NSMutableArray *_observers;
}

+ (id)entityWithObject:(id <NSCoding>)object store:(LCStore *)store {
  return [[self alloc] initWithID:[NSUUID UUID] object:object store:store];
}

- (id)initWithID:(NSUUID *)anObjectID object:(id <NSCoding>)object store:(LCStore *)store {
  self = [super init];
  if (self != nil) {
    _objectID = [anObjectID UUIDString];
    _store = store;
    _observers = [NSMutableArray array];
    _object = object;
    [self storeObject];
  }
  return self;
}

- (NSUUID *)objectID {
  return [[NSUUID alloc] initWithUUIDString:_objectID];
}

- (void)addObserver:(id <LCEntityObserver>)observer {
  [_observers addObject:observer];
  [_store subscribeToKey:_objectID observer:self];
}

- (void)removeObserver:(id <LCEntityObserver>)observer {
  [_observers removeObject:observer];
  if ([_observers count] == 0) {
    [_store unsubscribeFromKey:_objectID observer:self];
  }
}

- (void)emitUpdateEvent {
  [_observers forEach:^(id <LCEntityObserver> each) {
    [each updatedEntity:self];
  }];
}

- (void)emitDeleteEvent {
  [_observers forEach:^(id <LCEntityObserver> each) {
    [each deletedEntity:self];
  }];
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
  _object = nil;
}

- (void)readObject:(LCEntityReadHandler)handler {
  if (_object) {
    handler(_object);
  } else {
    [_store dataForKey:_objectID handler:^(NSData *data) {
      _object = [self deserialize:data];
      handler(_object);
    }];
  }
}

- (void)storeObject {
  if (_object) {
    NSData *data = [self serialize:_object];
    [_store updateData:data forKey:_objectID];
  }
}

- (void)updateObject:(LCEntityUpdateHandler)handler {
  [self readObject:^(id object) {
    handler(object, ^() {
      [self storeObject];
    });
  }];
}

- (void)deleteObject {
  [_store deleteDataForKey:_objectID];
}

/*
 LCDataObserver protocol
*/

- (void)updated:(NSString *)key {
  [self emitUpdateEvent];
}

- (void)deleted:(NSString *)key {
  [self emitDeleteEvent];
}

/*
 NSCoding protocol
*/

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    _objectID = [aDecoder decodeObjectForKey:@"objectID"];
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
