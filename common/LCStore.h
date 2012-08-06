
#import <Foundation/Foundation.h>
#import "LCEntity.h"

@protocol LCManagedObject;

typedef id(^LCStoreCreateBlock)();
enum LCStoreChangeType {
  LCStoreObjectUpdated,
  LCStoreObjectDeleted
  };
typedef void(^LCStoreSubscribeBlock)();

@interface LCStore : NSObject
- (LCEntity *)entityWithClass:(Class)aClass;
- (id <LCManagedObject>)createManagedObjectWithConstructor:(LCStoreCreateBlock)block;
- (void)updateManagedObject:(id <LCManagedObject>)object;
- (void)deleteManagedObject:(id <LCManagedObject>)object;
- (void)subscribeToObjectID:(NSString *)id withEntity:(NSString *)entity
  updateBlock:(LCStoreSubscribeBlock)block deleteBlock:(LCStoreSubscribeBlock) block;
@end
