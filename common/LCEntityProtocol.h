
#import <Foundation/Foundation.h>
@class LCStore;

@protocol LCEntity <NSObject>
@required
@property (readonly) NSString *objectID;
+ (id)objectWithID:(NSString *)objectID data:(NSData *)data store:(LCStore *)store;
- (NSData *)serialize;
- (void)deserializeWithData:(NSData *)data store:(LCStore *)store;
@end
