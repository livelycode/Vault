
#import <Foundation/Foundation.h>
#import "LCUtils.h"

@class LCEntity;
typedef void(^LCStoreReadBlock)(NSArray *objects);

@interface LCStore : NSObject <NSFilePresenter>
+ (id)storeWithURL:(NSURL *)url;
- (void)updateObject:(LCEntity *)object;
- (void)deleteObject:(LCEntity *)object;
- (void)objectsForIDs:(NSArray *)objectIDs completionHandler:(LCStoreReadBlock)success;
@end
