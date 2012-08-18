
#import "LCAppStore.h"
#import "LCStore.h"
#import "LCEntity.h"
#import "LCCategoryList.h"
#import "LCCategory.h"
#import "LCEntry.h"
#import "LivelyBlocks.h"

static LCAppStore *_sharedStore = nil;

@implementation LCAppStore {
  LCStore *_store;
  LCEntity *_categoryListEntity;
}

+ (LCAppStore *)store {
  if (!_sharedStore) {
    _sharedStore = [[self alloc] init];
  }
  return _sharedStore;
}

- (id)init {
  self = [super init];
  if (self) {
    _store = [LCStore storeWithURL:[NSURL fileURLWithPath:@"/Users/mirko/test" isDirectory:YES]];
    LCCategoryList *categoryList = [[LCCategoryList alloc] init];
    NSArray *categoryNames = @[ @"category1", @"category2", @"category3" ];
    for (int i=0; i<10; i++) {
      [categoryNames forEach:^(NSString *each) {
        LCCategory *category = [[LCCategory alloc] init];
        category.name = each;
        LCEntity *categoryEntity = [LCEntity entityWithObject:category store:_store];
        [categoryList insertCategory:categoryEntity atIndex:0];
      }];
    }
    _categoryListEntity = [LCEntity entityWithObject:categoryList store:_store];
    [_categoryListEntity uncacheObject];
  }
  return self;
}

- (LCEntity *)categoryList {
  return _categoryListEntity;
}

- (LCEntity *)createCategory {
  return [LCEntity entityWithObject:[[LCCategory alloc] init] store:_store];
}

- (LCEntity *)createEntry {
  return [LCEntity entityWithObject:[[LCEntry alloc] init] store:_store];
}

@end
