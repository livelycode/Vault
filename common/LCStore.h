
#import <Foundation/Foundation.h>

@protocol LCEntity;

typedef id <LCEntity>(^LCStoreCreateBlock)();
typedef void(^LCStoreSubscribeBlock)();

@interface LCStore : NSObject
+ (id)storeWithURL:(NSURL *)url;
- (id <LCEntity>)createObjectWithConstructor:(LCStoreCreateBlock)block;
- (void)updateObject:(id <LCEntity>)object;
- (void)deleteObject:(id <LCEntity>)object;
- (NSSet *)objectsOfClass:(Class)aClass;
- (id <LCEntity>)objectForID:(NSString *)objectID;
- (void)subscribeToObject:(id <LCEntity>)object updateBlock:(LCStoreSubscribeBlock)block deleteBlock:(LCStoreSubscribeBlock)block;
@end
