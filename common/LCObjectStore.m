
#import "LCObjectStore.h"
#import "LCEntity.h"
#import "LivelyBlocks.h"

@implementation LCObjectStore {
  LCStore *_store;
  NSMapTable *_objects;
}

+ (id)objectStoreWithStore:(LCStore *)store {
  return [[self alloc] initWithStore:store];
}

- (id)initWithStore:(LCStore *)store {
  self = [super init];
  if (self) {
    _store = store;
    _objects = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory valueOptions:NSMapTableWeakMemory];
  }
  return self;
}

- (void)storeObject:(id <NSCoding>)object forKey:(NSString *)key {
  [_objects setObject:object forKey:key];
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
  [_store storeData:data forKey:key];
}

- (void)deleteObjectForKey:(NSString *)key {
  [_store deleteDataForKey:key];
}

- (id)deserialize:(NSData *)data {
  NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
  unarchiver.delegate = self;
  id object = [unarchiver decodeObjectForKey:@"root"];
  [unarchiver finishDecoding];
  return object;
}

- (void)objectForKey:(NSString *)key handler:(LCObjectBlock)handler {
  id cachedObject = [_objects objectForKey:key];
  if (cachedObject) {
    handler(cachedObject);
  }
  [_store dataForKey:key handler:^(NSData *data) {
    id cachedObject = [self deserialize:data];
    [_objects setObject:cachedObject forKey:key];
    handler(cachedObject);
  }];
}

- (void)subscribeToKey:(NSString *)key observer:(id <LCKeyObserver>)observer {
  [_store subscribeToKey:key observer:observer];
}

- (void)unsubscribeFromKey:(NSString *)key observer:(id <LCKeyObserver>)observer {
  [_store unsubscribeFromKey:key observer:observer];
}

/*
 NSUnarchiver delegate protocol
 */

- (id)unarchiver:(NSKeyedUnarchiver *)unarchiver didDecodeObject:(id)object {
  if([object isKindOfClass:[LCEntity class]]) {
    [object setStore:self];
  }
  return object;
}
@end
