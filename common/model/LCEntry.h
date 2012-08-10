
#import <Foundation/Foundation.h>
#import "LCEntity.h"

@interface LCEntry : LCEntity
@property (readonly, strong) NSDictionary *fields;
- (void)setFieldValue:(NSString *)value withID:(NSString *)objectID;
- (void)removeFieldValueWithID:(NSString *)objectID;
@end
