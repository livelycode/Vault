
#import <Foundation/Foundation.h>

typedef void(^LCNotifyBlock)();

NSData *LCCreateSerializedPropertyList(id anObject);
id LCCreateDeserializedPropertyList(NSData *data);