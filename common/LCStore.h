
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCEntityStoring.h"

typedef void(^LCStoreReadBlock)(NSArray *objects);

@interface LCStore : NSObject <NSFilePresenter>
+ (id)storeWithURL:(NSURL *)url;
- (void)updateObject:(id <LCEntityStoring>)object;
- (void)deleteObject:(id <LCEntityStoring>)object;
- (void)objectsForIDs:(NSArray *)objectIDs completionHandler:(LCStoreReadBlock)success;
@end

@protocol LCStoreEntity

@end