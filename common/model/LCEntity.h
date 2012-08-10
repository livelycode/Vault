
#import <Foundation/Foundation.h>
#import "LCUtils.h"

@class LCStore;

@interface LCEntity : NSObject
@property (readonly) NSUUID *objectID;
+ (id)entityWithStore:(LCStore *)store;
+ (id)objectWithID:(NSUUID *)objectID store:(LCStore *)store;
- (NSData *)serialize;
- (void)deserializeWithData:(NSData *)data;
- (void)deleted;
- (void)subscribeWithUpdateHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID;
- (void)subscribeWithDeleteHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID;;
- (void)unsubscribeUpdateHandler:(NSUUID *)handlerID;
- (void)unsubscribeDeleteHandler:(NSUUID *)handlerID;
@end
