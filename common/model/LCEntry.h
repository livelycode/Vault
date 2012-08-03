
#import <Foundation/Foundation.h>

#import "LCManagedObject.h"

@interface LCEntry : NSObject <LCManagedObject>
@property (readonly, strong) NSUUID *objectID;
@property (readonly, strong) NSDictionary *fields;
- (void)setFieldValue:(NSString *)value withID:(NSUUID *)objectID;
- (void)removeFieldValueWithID:(NSUUID *)objectID;
@end
