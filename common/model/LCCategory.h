
#import <Foundation/Foundation.h>

@class LCEntry;

@interface LCCategory : NSObject <NSCoding>
@property (readonly) NSDictionary *fields; // keys are UUIDs
@property (readwrite, strong) NSString *name;
@property (readonly) NSArray *entries;
- (void)addField:(NSString *)name withID:(NSString *)objectID;
- (void)removeFieldWithID:(NSString *)objectID;
- (void)addEntry:(LCEntry *)entry;
- (void)removeEntry:(LCEntry *)entry;
@end
