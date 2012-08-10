
#import "LCEntity.h"
#import "LCCategory.h"

@interface LCCategoryList : NSObject <NSCoding>
@property (readonly) NSArray *categories;
- (void)insertCategory:(LCCategory *)category atIndex:(NSUInteger)index;
- (void)removeCategoryAtIndex:(NSUInteger)index;
@end
