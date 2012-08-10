
#import <Foundation/Foundation.h>

@class LCEntity;

@interface LCCategory : NSObject <NSCoding>
@property (readonly) NSDictionary *fields; // keys are UUIDs
@property (readwrite, strong) NSString *name;
@property (readonly) NSArray *entries;
- (void)addField:(NSString *)name withID:(NSString *)objectID;
- (void)removeFieldWithID:(NSString *)objectID;
- (void)addEntry:(LCEntity *)entry;
- (void)removeEntry:(LCEntity *)entry;
@end
