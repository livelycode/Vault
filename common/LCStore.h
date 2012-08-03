
#import <Foundation/Foundation.h>
#import "LCEntity.h"

@protocol LCManagedObject;

typedef id(^LCStoreCreateBlock)();

@interface LCStore : NSObject
- (LCEntity *)entityWithName:(NSString *)name;
- (id <LCManagedObject>)createManagedObjectWithConstructor:(LCStoreCreateBlock)block;
- (void)updateManagedObject:(id <LCManagedObject>)object;
- (void)deleteManagedObject:(id <LCManagedObject>)object;
@end
