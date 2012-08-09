
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

- (void)deserializeWithData:(NSData *)data store:(LCStore *)store completionHandler:(LCNotifyBlock)completionHandler {
  NSArray *deserializedData = LCCreateDeserializedPropertyList(data);
  [store objectsForIDs:deserializedData completionHandler:^(NSArray *objects) {
    _categories = [NSMutableArray arrayWithArray:objects];
    completionHandler();
  }];
}

@end
