
#import <Foundation/Foundation.h>
#import "LCEntity.h"

@protocol LCManagedObject;

typedef id <LCManagedObject>(^LCStoreCreateBlock)();
typedef void(^LCStoreSubscribeBlock)();

@interface LCStore : NSObject
+ (id)storeWithURL:(NSURL *)url;
- (id <LCManagedObject>)createObjectWithConstructor:(LCStoreCreateBlock)block;
- (void)updateObject:(id <LCManagedObject>)object;
- (void)deleteObject:(id <LCManagedObject>)object;
- (NSSet *)objectsOfClass:(Class)aClass;
- (id <LCManagedObject>)objectForID:(NSString *)objectID;
- (void)subscribeToObject:(id <LCManagedObject>)object updateBlock:(LCStoreSubscribeBlock)block deleteBlock:(LCStoreSubscribeBlock)block;
@end
