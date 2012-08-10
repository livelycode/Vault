
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCEntityStoring.h"

@class LCStore;

@interface LCEntity : NSObject <LCEntityStoring>
+ (id)entityWithStore:(LCStore *)store;
- (void)subscribeWithUpdateHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID;
- (void)subscribeWithDeleteHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID;;
- (void)unsubscribeUpdateHandler:(NSUUID *)handlerID;
- (void)unsubscribeDeleteHandler:(NSUUID *)handlerID;
@end