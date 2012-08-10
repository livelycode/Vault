
#import "LCStore.h"
#import "LivelyBlocks.h"
#import "LCWeakObject.h"
#import "LCUtils.h"
#import "LCEntity.h"

@implementation LCStore {
  NSURL *_url;
  NSOperationQueue *_queue;
  NSMutableDictionary *_loadedObjects;
}

+ (id)storeWithURL:(NSURL *)url {
  return [[self alloc] initWithURL:url];
}

- (id)initWithURL:(NSURL *)url {
  self = [super init];
  if (self) {
    _url = url;
    _loadedObjects = [NSMutableDictionary dictionary];
    _queue = [[NSOperationQueue alloc] init];
    [NSFileCoordinator addFilePresenter:self];
  }
  return self;
}

- (NSURL *)objectURLWithID:(NSString *)objectID {
  return [_url URLByAppendingPathComponent:objectID];
}

- (NSURL *)objectURL:(LCEntity *)object {
  return [self objectURLWithID:[object.objectID UUIDString]];
}

- (void)updateObject:(LCEntity *)object {
  NSData *serialized = [self serializeEntity:object];
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:[self objectURL:object] options:NSFileCoordinatorWritingForMerging error:NULL byAccessor: ^(NSURL *newURL) {
    [serialized writeToURL:newURL atomically:YES];
  }];
}

- (void)deleteObject:(LCEntity *)object {
  NSFileCoordinator *coordinater = [[NSFileCoordinator alloc] initWithFilePresenter:self];
  [coordinater coordinateWritingItemAtURL:[self objectURL:object] options:NSFileCoordinatorWritingForDeleting error:NULL byAccessor:^(NSURL *newURL) {
    [[NSFileManager defaultManager] removeItemAtURL:newURL error:NULL];
  }];
}

- (NSData *)serializeEntity:(LCEntity *)object {
  NSData *serializedData = [object serialize];
  NSDictionary *entityWrapper = @{ @"class": NSStringFromClass([object class]), @"data": serializedData, @"id": [object.objectID UUIDString]};
  return LCCreateSerializedPropertyList(entityWrapper);
}

- (LCEntity *)deserializeEntity:(NSData *)data {
  NSDictionary *entityWrapper = LCCreateDeserializedPropertyList(data);
  Class class = NSClassFromString(entityWrapper[@"class"]);
  NSUUID *objectID = [[NSUUID alloc] initWithUUIDString:entityWrapper[@"id"]];
  LCEntity * entity = [class objectWithID:objectID store:self];
  [entity deserializeWithData:data];
  return entity;
}

- (void)objectsForIDs:(NSArray *)objectIDs completionHandler:(LCStoreReadBlock)success {
  NSMutableDictionary *objects = [NSMutableDictionary dictionary];
  NSMutableArray *idsToLoad = [NSMutableArray array];
  NSMutableArray *urlsToLoad = [NSMutableArray array];
  [objectIDs forEach:^void(id each) {
    LCWeakObject *weakObject = _loadedObjects[each];
    if ([weakObject notNil]) {
      objects[each] = weakObject.object;
    } else {
      [idsToLoad addObject:each];
      [urlsToLoad addObject:[self objectURLWithID:each]];
    }
  }];
  if ([urlsToLoad count] > 0) {
    NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:self];
    [coordinator prepareForReadingItemsAtURLs:urlsToLoad options:NSFileCoordinatorReadingWithoutChanges writingItemsAtURLs:nil options:0 error:NULL byAccessor: ^(void (^completionHandler)(void)) {
       for(NSString *objectID in idsToLoad){
         [coordinator coordinateReadingItemAtURL:[self objectURLWithID:objectID] options:NSFileCoordinatorReadingWithoutChanges error:NULL byAccessor: ^(NSURL *newURL) {
           NSData *data = [NSData dataWithContentsOfURL:newURL];
           objects[objectID] = [self deserializeEntity:data];
         }];
       }
       completionHandler();
     }];
  }
  [idsToLoad forEach:^(id each) {
    LCEntity * entity = objects[each];
    _loadedObjects[entity.objectID] = [LCWeakObject weakObjectWithObject:entity];
  }];
  NSArray *resultObjects = [objectIDs collect:^id(id each) {
    return objects[each];
  }];
  success(resultObjects);
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
