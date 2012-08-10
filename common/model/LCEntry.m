
#import "LCEntry.h"
#import "LCUtils.h"

@interface LCEntry() {
  NSMutableDictionary *_fields;
}

@end

@implementation LCEntry

- (id)init {
  self = [super init];
  if (self != nil) {
    _fields = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)setFieldValue:(NSString *)value withID:(NSString *)fieldID {
  _fields[fieldID] = value;
}

- (void)removeFieldValueWithID:(NSString *)fieldID {
  [_fields removeObjectForKey:fieldID];
}

/*
 NSCoding protocol
*/
- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    _fields = [aDecoder decodeObjectForKey:@"fields"];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:_fields forKey:@"fields"];
}

@end
