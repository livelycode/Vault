
#import "LCEntity.h"
#import "LCCategory.h"

@interface LCCategoryList : LCEntity
@property (readonly) NSArray *categories;
- (void)insertCategory:(LCCategory *)category atIndex:(NSUInteger)index;
- (void)removeCategoryAtIndex:(NSUInteger)index;
@end
