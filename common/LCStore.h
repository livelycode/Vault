
#import <Foundation/Foundation.h>
#import "LCUtils.h"

typedef void(^LCDataBlock)(NSData *data);
typedef void(^LCArrayBlock)(NSArray *dataObjects);

@protocol LCDataObserver <NSObject>
- (void)updated;
- (void)deleted;
@end

@interface LCStore : NSObject <NSFilePresenter>
+ (id)storeWithURL:(NSURL *)url;
- (void)createData:(NSData *)data forKey:(NSString *)key;
- (void)updateData:(NSData *)data forKey:(NSString *)key;
- (void)deleteDataForKey:(NSString *)key;
- (void)dataForKey:(NSString *)key handler:(LCDataBlock)handler;
- (void)dataForKeys:(NSArray *)keys completionHandler:(LCArrayBlock)success;
- (void)subscribeToKey:(NSString *)key observer:(id <LCDataObserver>)observer;
- (void)unsubscribe:(id <LCDataObserver>)observer;
@end
