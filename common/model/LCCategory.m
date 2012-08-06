
#import "LCCategory.h"
#import "LCUtils.h"
#import "LivelyBlocks.h"
#import "LCEntity.h"
#import "LCStore.h"
#import "LCEntry.h"

@interface LCCategory() {
  NSMutableDictionary *_fields;
  NSMutableArray *_entries;
}
@property (readwrite, strong) NSString *objectID;

@end

@implementation LCCategory
@synthesize objectID;

- (id)init {
  self = [super init];
  if (self != nil) {
    _fields = [NSMutableDictionary dictionary];
    _entries = [NSMutableArray array];
    self.objectID = [[NSUUID UUID] UUIDString];
  }
  return self;
}

- (NSDictionary *)fields {
  return _fields;
}

- (NSData *)serialize {
  NSArray *objectIDs = [_entries collect:^id(id each) {
    return [each objectID];
  }];
  NSDictionary *data = @{
  @"name": self.name,
  @"fields": _fields,
  @"entries": objectIDs
  };
  return LCCreateSerializedPropertyList(data);
}

- (void)deserializeWithData:(NSData *)data store:(LCStore *)store {
  NSDictionary *obj = LCCreateDeserializedPropertyList(data);
  self.name = obj[@"name"];
  _fields = [NSMutableDictionary dictionaryWithDictionary:obj[@"fields"]];
  NSArray *entryIDs = obj[@"entries"];
  LCEntity *entryEntity = [store entityWithClass:[LCEntry class]];
  NSArray *entries = [entryIDs collect:^id(id each) {
    entryEntity 
  }];
}

- (void)addField:(NSString *)name withID:(NSString *)fieldID {
  _fields[fieldID] = fieldID;
}

- (void)removeFieldWithID:(NSString *)fieldID {
  [_fields removeObjectForKey:fieldID];
}

- (void)addEntry:(LCEntry *)entry {
  [_entries addObject:entry];
}

- (void)removeEntry:(LCEntry *)entry {
  [_entries removeObject:entry];
}

@end