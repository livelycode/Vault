
#import <Foundation/Foundation.h>

typedef void (^LCKeyDataBlock)(NSString *key, NSData *data);
typedef void (^LCKeyBlock)(NSString *key);

@interface LCEntity : NSObject
- (void)registerAddBlock:(LCKeyDataBlock)block withID:(NSUUID *)id;
- (void)registerUpdateBlock:(LCKeyDataBlock)block withID:(NSUUID *)id;
- (void)registerDeleteBlock:(LCKeyDataBlock)block withID:(NSUUID *)id;
- (void)unregisterAddBlockWithID:(NSUUID *)id;
- (void)unregisterUpdateBlockWithID:(NSUUID *)id;
- (void)unregisterDeleteBlockWithID:(NSUUID *)id;
- (void)setValue:(NSData *)value forKey:(NSString *)key;
- (void)removeKey:(NSString *)key;
@end
