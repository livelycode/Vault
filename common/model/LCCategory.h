
#import <Foundation/Foundation.h>
#import "LCManagedObjectProtocol.h"
#import "LCManagedObject.h"

@class LCEntry;

@interface LCCategory : LCManagedObject
@property (readonly) NSDictionary *fields; // keys are UUIDs
@property (readwrite, strong) NSString *name;
@property (readonly) NSArray *entries;
- (void)addField:(NSString *)name withID:(NSString *)objectID;
- (void)removeFieldWithID:(NSString *)objectID;
- (void)addEntry:(LCEntry *)entry;
- (void)removeEntry:(LCEntry *)entry;
@end
