
#import "LCStore.h"

@interface LCStore() <NSFilePresenter>
@property (readwrite, strong) NSURL *url;
@end

@implementation LCStore

+ (id)storeWithURL:(NSURL *)url {
  LCStore *object = [[self alloc] init];
  object.url = url;
  [NSFileCoordinator addFilePresenter:object];
  return object;
}

- (id <LCEntity>)createObjectWithConstructor:(LCStoreCreateBlock)block {
  id <LCEntity> object = block();
  NSData *serialized = [object serialize];
  NSURL *objectURL = [self.url URLByAppendingPathComponent:object.objectID];
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:objectURL options:NSFileCoordinatorWritingForMerging error:NULL byAccessor:^(NSURL *newURL) {
    [serialized writeToURL:newURL atomically:YES];
  }];
  return object;
}

@end
