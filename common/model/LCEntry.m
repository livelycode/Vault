
#import "LCEntry.h"
#import "LCUtils.h"

@interface LCEntry() {
  NSMutableDictionary *_fields;
}
@property (readwrite, strong) NSString *objectID;

@end

@implementation LCEntry

- (id)init {
  self = [super init];
  if (self != nil) {
    _fields = [NSMutableDictionary dictionary];
    self.objectID = [[NSUUID UUID] UUIDString];
  }
  return self;
}

- (void)setFieldValue:(NSString *)value withID:(NSString *)fieldID {
  _fields[fieldID] = value;
}

- (void)removeFieldValueWithID:(NSString *)fieldID {
  [_fields removeObjectForKey:fieldID];
}

- (NSData *)serialize {
  return LCCreateSerializedPropertyList(_fields);
}

- (void)deserializeWithData:(NSData *)data store:(LCStore *)store {
  NSDictionary *obj = LCCreateDeserializedPropertyList(data);
  _fields = [NSMutableDictionary dictionaryWithDictionary:obj];
}

@end
