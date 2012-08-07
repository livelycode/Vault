
#import <Foundation/Foundation.h>
@class LCStore;

@protocol LCManagedObject <NSObject>
@required
+ (id)objectWithID:(NSString *)objectID data:(NSData *)data store:(LCStore *)store;
- (NSString *)objectID;
- (NSData *)serialize;
- (void)deserializeWithData:(NSData *)data store:(LCStore *)store;
@end
