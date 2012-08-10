
#import "LCEntity.h"
#import "LivelyBlocks.h"

@implementation LCEntity {
  NSUUID *_objectID;
  id <NSCoding> _object;
  LCStore *_store;
  NSMutableDictionary *_updateHandlers;
  NSMutableDictionary *_deleteHandlers;
}

+ (id)entityWithObject:(id<NSCoding>)object store:(LCStore *)store {
  return [[self alloc] initWithID:[NSUUID UUID] object:object store:store];
}

- (id)initWithID:(NSUUID *)anObjectID object:(id <NSCoding>)object store:(LCStore *)store {
  self = [super init];
  if (self != nil) {
    _objectID = anObjectID;
    _object = object;
    _store = store;
    _updateHandlers = [NSMutableDictionary dictionary];
    _deleteHandlers = [NSMutableDictionary dictionary];
  }
  return self;
}

- (NSUUID *)objectID {
  return _objectID;
}

- (void)subscribeWithUpdateHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID {
  if (!handlerID) {
    handlerID = [NSUUID UUID];
  }
  _updateHandlers[handlerID] = block;
}

- (void)subscribeWithDeleteHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID {
  if (!handlerID) {
    handlerID = [NSUUID UUID];
  }
  _deleteHandlers[handlerID] = block;
}

- (void)unsubscribeUpdateHandler:(NSUUID *)handlerID {
  [_updateHandlers removeObjectForKey:handlerID];
}

- (void)unsubscribeDeleteHandler:(NSUUID *)handlerID {
  [_deleteHandlers removeObjectForKey:handlerID];
}

- (void)emitChangeEvent {
  [_updateHandlers keysAndValues:^(id key, id value) {
    LCNotifyBlock handler = value;
    handler();
  }];
}

- (void)emitDeleteEvent {
  [_deleteHandlers keysAndValues:^(id key, id value) {
    LCNotifyBlock handler = value;
    handler();
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

- (void)readObject:(LCEntityAccessHandler)handler {
  
}

- (void)updateObject:(LCEntityAccessHandler)handler {
  
}

- (void)deleteObject {
  
}

/*
 LCDataObserver protocol
*/

- (void)updated {
  [self emitChangeEvent];
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
