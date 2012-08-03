
#import <Foundation/Foundation.h>

#import "LCManagedObject.h"

@interface LCCategory : NSObject <LCManagedObject>
@property (readonly, strong) NSDictionary *fields; // keys are UUIDs
@property (readwrite, strong) NSString *name;
- (void)addField:(NSString *)name withID:(NSUUID *)objectID;
- (void)removeFieldWithID:(NSUUID *)objectID;
@end
