
#import <Foundation/Foundation.h>

typedef void(^LCEventBlock)(id message);

@interface LCEventEmitter : NSObject
+ (id)eventEmitter;
- (void)emitEvent:(NSString *)event withMessage:(id)message;
- (void)registerEvent:(NSString *)event withHandler:(LCEventBlock)eventHandler;
- (void)registerEvent:(NSString *)event withHandler:(LCEventBlock)eventHandler handlerID:(NSUUID *)handlerID;
- (void)removeHandlerWithID:(NSUUID *)handlerID forEvent:(NSString *)event;
@end
