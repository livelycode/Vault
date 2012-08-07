
#import <Foundation/Foundation.h>
#import "LCEntityProtocol.h"
#import "LCManagedObject.h"

@interface LCEntry : LCManagedObject
@property (readonly, strong) NSDictionary *fields;
- (void)setFieldValue:(NSString *)value withID:(NSString *)objectID;
- (void)removeFieldValueWithID:(NSString *)objectID;
@end
