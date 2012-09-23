
#import "LCEventEmitter.h"
#import "LivelyBlocks.h"

@interface LCEventEmitter()
@property (readwrite, strong) NSMutableDictionary *handlers;
- (NSMutableArray *)handlersForEvent:(NSString *)event;
@end

@implementation LCEventEmitter

+ (id)eventEmitter {
  LCEventEmitter *object = [[self alloc] init];
  object.handlers = [NSMutableDictionary dictionary];
  return object;
}

- (void)emitEvent:(NSString *)event withMessage:(id)message {
  NSMutableArray *eventHandlers = self.handlers[event];
  for (LCEventBlock eachBlock in eventHandlers) {
    eachBlock(message);
  }
}

- (void)registerEvent:(NSString *)event withHandler:(LCEventBlock)eventHandler {
  NSMutableArray *eventHandlers = [self handlersForEvent:event];
  [eventHandlers addObject:[eventHandler copy]];
}

- (void)registerEvent:(NSString *)event withHandler:(LCEventBlock)eventHandler handlerID:(NSUUID *)handlerID {
  [[self handlersForEvent:event] addObject:@{ @"id" : handlerID, @"handler": eventHandler }];
}

- (NSMutableArray *)handlersForEvent:(NSString *)event {
  NSMutableArray *eventHandlers = self.handlers[event];
  if (!eventHandlers) {
    eventHandlers = [NSMutableArray array];
    self.handlers[event] = eventHandlers;
  }
  return eventHandlers;
}

- (void)removeHandlerWithID:(NSUUID *)handlerID forEvent:(NSString *)event {
  NSMutableArray *eventHandlers = [self handlersForEvent:event];
  [eventHandlers forEach:^(NSDictionary *each) {
    if ([each[@"id"] isEqual: handlerID]) {
      [eventHandlers removeObject:each];
    }
  }];
}

@end
