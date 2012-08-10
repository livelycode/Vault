
#import "LCStore.h"
#import "LivelyBlocks.h"
#import "LCWeakObject.h"
#import "LCUtils.h"

@implementation LCStore {
  NSURL *_url;
  NSOperationQueue *_queue;
}

+ (id)storeWithURL:(NSURL *)url {
  return [[self alloc] initWithURL:url];
}

- (id)initWithURL:(NSURL *)url {
  self = [super init];
  if (self) {
    _url = url;
    _queue = [[NSOperationQueue alloc] init];
    [NSFileCoordinator addFilePresenter:self];
  }
  return self;
}

- (NSURL *)URLWithKey:(NSString *)key {
  return [_url URLByAppendingPathComponent:key];
}

- (void)createData:(NSData *)data withKey:(NSString *)key {
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:[self URLWithKey:key] options:NSFileCoordinatorWritingForReplacing error:NULL byAccessor: ^(NSURL *newURL) {
    [data writeToURL:newURL atomically:YES];
  }];
}

- (void)updateData:(NSData *)data withKey:(NSString *)key {
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:[self URLWithKey:key] options:NSFileCoordinatorWritingForMerging error:NULL byAccessor: ^(NSURL *newURL) {
    [data writeToURL:newURL atomically:YES];
  }];
}

- (void)deleteDataWithKey:(NSString *)key {
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:[self URLWithKey:key] options:NSFileCoordinatorWritingForDeleting error:NULL byAccessor:^(NSURL *newURL) {
    [[NSFileManager defaultManager] removeItemAtURL:newURL error:NULL];
  }];
}

- (void)dataForKey:(NSString *)key handler:(LCDataBlock)handler {
  NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinator coordinateReadingItemAtURL:[self URLWithKey:key] options:NSFileCoordinatorReadingWithoutChanges error:NULL byAccessor: ^(NSURL *newURL) {
    handler([NSData dataWithContentsOfURL:newURL]);
  }];
}

- (void)dataForKeys:(NSArray *)keys completionHandler:(LCArrayBlock)success {
  NSMutableArray *dataObjects = [NSMutableDictionary dictionary];
  NSMutableArray *urlsToLoad = [NSMutableArray array];
  [keys collect:^id(id each) {
    return [self URLWithKey:each];
  }];
  NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinator prepareForReadingItemsAtURLs:urlsToLoad options:NSFileCoordinatorReadingWithoutChanges writingItemsAtURLs:nil options:0 error:NULL byAccessor: ^(void (^completionHandler)(void)) {
    for(NSURL *url in urlsToLoad){
      [coordinator coordinateReadingItemAtURL:url options:NSFileCoordinatorReadingWithoutChanges error:NULL byAccessor: ^(NSURL *newURL) {
        [dataObjects addObject:[NSData dataWithContentsOfURL:newURL]];
      }];
    }
    completionHandler();
  }];
  success(dataObjects);
}

- (void)notifyChangeWithKey:(NSString *)key handler:(LCNotifyBlock)handler {
  
}

- (void)notifyDeleteWithKey:(NSString *)key handler:(LCNotifyBlock)handler {
  
}

/*
 NSFilePresenter protocol
*/
- (NSURL *)presentedItemURL {
  return _url;
}

- (NSOperationQueue *)presentedItemOperationQueue {
  return _queue;
}

@end
