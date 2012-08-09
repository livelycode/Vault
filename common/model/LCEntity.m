
#import "LCEntity.h"
#import "LivelyBlocks.h"

@implementation LCEntity {
  NSUUID *_objectID;
  LCStore *_store;
  NSMutableDictionary *_updateHandlers;
  NSMutableDictionary *_deleteHandlers;
}

+ (id)objectWithID:(NSUUID *)objectID store:(LCStore *)store {
  id object = [[self alloc] initWithID:objectID store:store];
  return object;
}

- (id)initWithID:(NSUUID *)anObjectID store:(LCStore *)store {
  self = [super init];
  if (self != nil) {
    _objectID = anObjectID;
    _store = store;
    _updateHandlers = [NSMutableDictionary dictionary];
    _deleteHandlers = [NSMutableDictionary dictionary];
  }
  return self;
}

- (NSData *)serialize {
  return nil;
}

- (void)deserializeWithData:(NSData *)data {
  [self deserializeWithData:data completionHandler:^{
    [self emitChangeEvent];
  }];
}

- (void)deserializeWithData:(NSData *)data completionHandler:(LCNotifyBlock)block {
  block();
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

- (void)deleted {
  [self emitDeleteEvent];
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

@end
