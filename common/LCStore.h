
#import <Foundation/Foundation.h>
#import "LCUtils.h"

typedef void(^LCDataBlock)(NSData *data);

@interface LCStore : NSObject <NSFilePresenter>
+ (id)storeWithURL:(NSURL *)url;
- (void)storeData:(NSData *)data forKey:(NSString *)key;
- (void)deleteDataForKey:(NSString *)key;
- (void)dataForKey:(NSString *)key handler:(LCDataBlock)handler;
- (void)dataForKeys:(NSArray *)keys completionHandler:(LCArrayBlock)success;
- (void)subscribeToKey:(NSString *)key observer:(id <LCKeyObserver>)observer;
- (void)unsubscribeFromKey:(NSString *)key observer:(id <LCKeyObserver>)observer;
@end
