
#import <Foundation/Foundation.h>
#import "LCEntityProtocol.h"
#import "LCUtils.h"

typedef id <LCEntity>(^LCStoreCreateBlock)();
typedef void(^LCStoreReadBlock)(NSArray *objects);


@interface LCStore : NSObject <NSFilePresenter>
+ (id)storeWithURL:(NSURL *)url;
- (id <LCEntity>)createObjectWithConstructor:(LCStoreCreateBlock)block;
- (void)updateObject:(id <LCEntity>)object;
- (void)deleteObject:(id <LCEntity>)object;
- (void)objectsForIDs:(NSArray *)objectIDs completionHandler:(LCStoreReadBlock)success;
@end
