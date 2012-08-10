
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCDataObserver.h"

typedef void(^LCDataBlock)(NSData *data);
typedef void(^LCArrayBlock)(NSArray *dataObjects);

@interface LCStore : NSObject <NSFilePresenter>
+ (id)storeWithURL:(NSURL *)url;
- (void)createData:(NSData *)data withKey:(NSString *)key;
- (void)updateData:(NSData *)data withKey:(NSString *)key;
- (void)deleteDataWithKey:(NSString *)key;
- (void)dataWithKey:(NSString *)key handler:(LCDataBlock)handler;
- (void)dataForKeys:(NSArray *)keys completionHandler:(LCArrayBlock)success;
- (void)subscribeToKey:(NSString *)key observer:(id <LCDataObserver>)observer;
- (void)unsubscribe:(id <LCDataObserver>)observer;
@end
