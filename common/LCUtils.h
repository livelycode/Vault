
#import <Foundation/Foundation.h>

typedef void(^LCNotifyBlock)();
typedef void(^LCBlock)();
typedef void(^LCArrayBlock)(NSArray *dataObjects);
typedef void(^LCObjectBlock)(id object);


NSData *LCCreateSerializedPropertyList(id anObject);
id LCCreateDeserializedPropertyList(NSData *data);

@protocol LCKeyObserver <NSObject>
- (void)updated:(NSString *)key;
- (void)deleted:(NSString *)key;
@end