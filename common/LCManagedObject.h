
#import <Foundation/Foundation.h>
@class LCStore;

@protocol LCManagedObject <NSObject>
@required
- (NSString *)objectID;
- (NSData *)serialize;
- (void)deserializeWithData:(NSData *)data store:(LCStore *)store;
@end
