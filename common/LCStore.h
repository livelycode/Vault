
#import <Foundation/Foundation.h>
#import "LCEntityProtocol.h"
#import "LCUtils.h"

typedef id <LCEntity>(^LCStoreCreateBlock)();
typedef void(^LCStoreReadBlock)(NSArray *objects);


@interface LCStore : NSObject
+ (id)storeWithURL:(NSURL *)url;
- (id <LCEntity>)createObjectWithConstructor:(LCStoreCreateBlock)block;
- (void)updateObject:(id <LCEntity>)object;
- (void)deleteObject:(id <LCEntity>)object;
- (void)objectsForIDs:(NSArray *)objectIDs completionHandler:(LCStoreReadBlock)success;
- (void)subscribeToObject:(id <LCEntity>)object updateBlock:(LCNotifyBlock)block;
- (void)subscribeToObject:(id <LCEntity>)object deleteBlock:(LCNotifyBlock)block;
- (void)unsubscribeUpdateBlock:(LCNotifyBlock)block;
- (void)unsubscribeDeleteBlock:(LCNotifyBlock)block;
@end
