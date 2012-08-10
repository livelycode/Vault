
#import <Foundation/Foundation.h>

@class LCStore;

@protocol LCEntityStoring <NSObject>
@required
@property (readonly) NSUUID *objectID;
+ (id)objectWithID:(NSUUID *)objectID store:(LCStore *)store;
- (NSData *)serialize;
- (void)deserializeWithData:(NSData *)data;
- (void)deleted;
@end
