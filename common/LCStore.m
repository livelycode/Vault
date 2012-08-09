
#import "LCStore.h"
#import "LivelyBlocks.h"

@interface LCStore() <NSFilePresenter>
@property (readwrite, strong) NSURL *url;
@property (readwrite, strong) NSMutableDictionary *loadedObjects;
@end

@implementation LCStore

+ (id)storeWithURL:(NSURL *)url {
  LCStore *object = [[self alloc] init];
  object.url = url;
  object.loadedObjects = [NSMutableDictionary dictionary];
  [NSFileCoordinator addFilePresenter:object];
  return object;
}

- (id <LCEntity>)createObjectWithConstructor:(LCStoreCreateBlock)block {
  id <LCEntity> object = block();
  [self updateObject:object];
  return object;
}

- (NSURL *)objectURLWithID:(NSString *)objectID {
  return [self.url URLByAppendingPathComponent:objectID];
}

- (NSURL *)objectURL:(id <LCEntity>)object {
  return [self objectURLWithID:object.objectID];
}

- (void)updateObject:(id<LCEntity>)object {
  NSData *serialized = [object serialize];
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:[self objectURL:object] options:NSFileCoordinatorWritingForMerging
                                    error:NULL byAccessor:^(NSURL *newURL) {
                                      [serialized writeToURL:newURL atomically:YES];
                                    }];
}

- (void)deleteObject:(id<LCEntity>)object {
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:[self objectURL:object] options:NSFileCoordinatorWritingForDeleting
                                    error:NULL byAccessor:^(NSURL *newURL) {
                                      [[NSFileManager defaultManager] removeItemAtURL:newURL error:NULL];
                                    }];
}

- (id <LCEntity>)deserializeEntity:(NSData *)data {
  return nil;
}

- (void)objectsForIDs:(NSArray *)objectIDs completionHandler:(LCStoreReadBlock)success {
  __block NSMutableDictionary *objects = [NSMutableDictionary dictionary];
  NSMutableArray *idsToLoad = [NSMutableArray array];
  NSMutableArray *urlsToLoad = [NSMutableArray array];
  [objectIDs forEach:^void(id each) {
    id object = self.loadedObjects[each];
    if (object) {
      objects[each] = object;
    } else {
      [idsToLoad addObject:each];
      [urlsToLoad addObject:[self objectURLWithID:each]];
    }
  }];
  if ([urlsToLoad count] > 0) {
    NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:self];
    [coordinator prepareForReadingItemsAtURLs:urlsToLoad options:NSFileCoordinatorReadingWithoutChanges writingItemsAtURLs:nil
                                      options:0 error:NULL byAccessor:
     ^(void (^completionHandler)(void)) {
       for(NSString *objectID in idsToLoad){
         [coordinator coordinateReadingItemAtURL:[self objectURLWithID:objectID] options:NSFileCoordinatorReadingWithoutChanges
                                           error:NULL byAccessor:
          ^(NSURL *newURL) {
            NSData *data = [NSData dataWithContentsOfURL:newURL];
            objects[objectID] = [self deserializeEntity:data];
          }];
       }
       completionHandler();
     }];
  }
  NSArray *resultObjects = [objectIDs collect:^id(id each) {
    return objects[each];
  }];
  success(resultObjects);
}

@end
