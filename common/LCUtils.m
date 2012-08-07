
#import "LCUtils.h"

NSData *LCCreateSerializedPropertyList(id object) {
  return [NSPropertyListSerialization dataWithPropertyList:object format:NSPropertyListBinaryFormat_v1_0 options:0 error: NULL];
}

id LCCreateDeserializedPropertyList(NSData *data) {
  return [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:NULL];
}