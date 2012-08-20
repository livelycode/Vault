
#import <Foundation/Foundation.h>

typedef void(^LCNotifyBlock)();
typedef void(^LCBlock)();


NSData *LCCreateSerializedPropertyList(id anObject);
id LCCreateDeserializedPropertyList(NSData *data);