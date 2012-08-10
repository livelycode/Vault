
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

- (void)addField:(NSString *)name withID:(NSString *)fieldID {
  _fields[fieldID] = fieldID;
}

- (void)removeFieldWithID:(NSString *)fieldID {
  [_fields removeObjectForKey:fieldID];
}

- (void)addEntry:(LCEntity *)entry {
  [_entries addObject:entry];
}

- (void)removeEntry:(LCEntity *)entry {
  [_entries removeObject:entry];
}

/*
 NSCoding protocol
*/
- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self != nil) {
    _fields = [aDecoder decodeObjectForKey:@"fields"];
    _entries = [aDecoder decodeObjectForKey:@"entries"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_fields forKey:@"fields"];
  [aCoder encodeObject:_entries forKey:@"entries"];
}
@end