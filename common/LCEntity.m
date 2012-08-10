
#import "LCEntity.h"
#import "LivelyBlocks.h"
#import "LCStore.h"

@implementation LCEntity {
  NSString *_objectID;
  id <NSCoding> _object;
  LCStore *_store;
  NSMutableArray *_observers;
}

+ (id)entityWithObject:(id<NSCoding>)object store:(LCStore *)store {
  return [[self alloc] initWithID:[NSUUID UUID] object:object store:store];
}

- (id)initWithID:(NSUUID *)anObjectID object:(id <NSCoding>)object store:(LCStore *)store {
  self = [super init];
  if (self != nil) {
    _objectID = [anObjectID UUIDString];
    _object = object;
    _store = store;
    _observers = [NSMutableArray array];
  }
  return self;
}

- (NSUUID *)objectID {
  return [[NSUUID alloc] initWithUUIDString:_objectID];
}

- (void)subscribeWithObserver:(id<LCEntityObserver>)observer {
  [_observers addObject:observer];
}

- (void)unsubscribeObserver:(id<LCEntityObserver>)observer {
  [_observers removeObject:observer];
}

- (void)emitUpdateEvent {
  [_observers forEach:^(id<LCEntityObserver> each) {
    [each updated:self];
  }];
}

- (void)emitDeleteEvent {
  [_observers forEach:^(id<LCEntityObserver> each) {
    [each deleted:self];
  }];
}

- (NSData *)serialize:(id <NSCoding>)object {
  return [NSKeyedArchiver archivedDataWithRootObject:_object];
}

- (id <NSCoding>)deserialize:(NSData *)data {
  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  unarchiver.delegate = self;
  [unarchiver finishDecoding];
  return [unarchiver decodeObjectForKey:@"root"];
}

- (void)uncacheObject {
  _object = nil;
}

- (void)readObject:(LCEntityReadHandler)handler {
  if (_object) {
    [_store dataForKey:_objectID handler:^(NSData *data) {
      _object = [self deserialize:data];
      handler(_object);
    }];
  } else {
    handler(_object);
  }
}

- (void)updateObject:(LCEntityUpdateHandler)handler {
  [self readObject:^(id object) {
    handler(object, ^() {
      NSData *data = [self serialize:object];
      [_store updateData:data forKey:_objectID];
    });
  }];
}

- (void)deleteObject {
  [_store deleteDataForKey:_objectID];
}

/*
 LCDataObserver protocol
*/

- (void)updated {
  [self emitUpdateEvent];
}

- (void)deleted {
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
  if([[object class] isSubclassOfClass:[LCEntity class]]) {
    [object setStore:_store];
  }
  return nil;
}

@end

@implementation LCEntityEvents

- (void)updated:(LCEntity *)entity {
  [self emitEvent:@"updated" withMessage:nil];
}

- (void)deleted:(LCEntity *)entity {
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
