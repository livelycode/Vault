
#import <Foundation/Foundation.h>

@class LCEntity, LCCategoryList;

@interface LCAppStore : NSObject
+ (LCAppStore *)store;
- (LCEntity *)categoryList;
- (LCEntity *)createCategory;
- (LCEntity *)createEntry;
@end
