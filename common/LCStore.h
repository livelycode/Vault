
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCStorableObject.h"

typedef void(^LCStoreReadBlock)(NSArray *objects);

@interface LCStore : NSObject <NSFilePresenter>
+ (id)storeWithURL:(NSURL *)url;
- (void)updateObject:(id <LCStorableObject>)object;
- (void)deleteObject:(id <LCStorableObject>)object;
- (void)objectsForIDs:(NSArray *)objectIDs completionHandler:(LCStoreReadBlock)success;
@end

@protocol LCStoreEntity

@end