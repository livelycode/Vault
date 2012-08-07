
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

- (void)insertCategory:(LCCategory *)category atIndex:(NSUInteger)index {
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

- (void)deserializeWithData:(NSData *)data store:(LCStore *)store {
  NSArray *deserializedData = LCCreateDeserializedPropertyList(data);
  NSArray *deserializedArray = [deserializedData collect:^id(id each) {
    return [store objectForID:each];
  }];
  _categories = [NSMutableArray arrayWithArray:deserializedArray];
}

@end
