
#import "LCCategory.h"
#import "LCUtils.h"
#import "LivelyBlocks.h"
#import "LCStore.h"
#import "LCEntry.h"

@interface LCCategory() {
  NSMutableDictionary *_fields;
  NSMutableArray *_entries;
}

@end

@implementation LCCategory

- (id)init {
  self = [super init];
  if (self != nil) {
    _fields = [NSMutableDictionary dictionary];
    _entries = [NSMutableArray array];
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

- (void)deserializeWithData:(NSData *)data store:(LCStore *)store completionHandler:(LCNotifyBlock)completionHandler {
  NSDictionary *obj = LCCreateDeserializedPropertyList(data);
  self.name = obj[@"name"];
  _fields = [NSMutableDictionary dictionaryWithDictionary:obj[@"fields"]];
  NSArray *entryIDs = obj[@"entries"];
  [store objectsForIDs:entryIDs completionHandler:^(NSArray *objects) {
    _entries = [NSMutableArray arrayWithArray:objects];
    completionHandler();
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