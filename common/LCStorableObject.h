
#import <Foundation/Foundation.h>

@class LCStore;

@protocol LCStorableObject <NSObject>
@required
@property (readonly) NSUUID *objectID;
+ (id)objectWithID:(NSUUID *)objectID store:(LCStore *)store;
- (NSData *)serialize;
- (void)deserializeWithData:(NSData *)data;
- (void)deleted;
@end
