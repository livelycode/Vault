
#import "LCCategoryList.h"
#import "LCUtils.h"
#import "LivelyBlocks.h"
#import "LCStore.h"

@interface LCCategoryList() {
  NSMutableArray *_categories;
}
@end

@implementation LCCategoryList

- (id)init {
  self = [super init];
  if(self != nil) {
    _categories = [NSMutableArray array];
  }
  return self;
}

- (void)insertCategory:(LCEntity *)category atIndex:(NSUInteger)index {
  [_categories insertObject:category atIndex:index];
}

- (NSArray *)categories {
  return _categories;
}

- (void)removeCategoryAtIndex:(NSUInteger)index {
  [_categories removeObjectAtIndex:index];
}

- (NSData *)serialize {
  return LCCreateSerializedPropertyList(_categories);
}

/*
 NSCoding Protocol
*/

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self != nil) {
    _categories = [aDecoder decodeObject];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_categories];
}

@end
