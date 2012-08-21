
#import <Foundation/Foundation.h>

typedef void(^LCNotifyBlock)();
typedef void(^LCBlock)();
typedef void(^LCArrayBlock)(NSArray *dataObjects);


NSData *LCCreateSerializedPropertyList(id anObject);
id LCCreateDeserializedPropertyList(NSData *data);