
#import <Foundation/Foundation.h>

#import "LCManagedObject.h"

@interface LCEntry : NSObject <LCManagedObject>
@property (readonly, strong) NSDictionary *fields;
- (void)setFieldValue:(NSString *)value withID:(NSString *)objectID;
- (void)removeFieldValueWithID:(NSString *)objectID;
@end
