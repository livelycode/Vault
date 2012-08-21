
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCStore.h"

@interface LCObjectStore : NSObject <NSKeyedUnarchiverDelegate>
+ (id)objectStoreWithStore:(LCStore *)store;
- (void)storeObject:(id <NSCoding>)object forKey:(NSString *)key;
- (void)deleteObjectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key handler:(LCObjectBlock)handler;
- (void)subscribeToKey:(NSString *)key observer:(id <LCKeyObserver>)observer;
- (void)unsubscribeFromKey:(NSString *)key observer:(id <LCKeyObserver>)observer;
@end
