
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCDataObserver.h"

@class LCStore;
typedef void(^LCDoneHandler)();
typedef void(^LCEntityReadHandler)(id object);
typedef void(^LCEntityUpdateHandler)(id object, LCDoneHandler done);

@interface LCEntity : NSObject <LCDataObserver, NSCoding, NSKeyedUnarchiverDelegate>
@property (readonly) NSUUID *objectID;
+ (id)entityWithObject:(id <NSCoding>)object store:(LCStore *)store;
- (void)subscribeWithUpdateHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID;
- (void)subscribeWithDeleteHandler:(LCNotifyBlock)block identifier:(NSUUID *)handlerID;;
- (void)unsubscribeUpdateHandler:(NSUUID *)handlerID;
- (void)unsubscribeDeleteHandler:(NSUUID *)handlerID;
- (void)readObject:(LCEntityReadHandler)handler;
- (void)updateObject:(LCEntityUpdateHandler)handler;
- (void)deleteObject;
@end