
#import <Foundation/Foundation.h>

@interface LCWeakObject : NSObject
@property (readonly, weak) id object;
+ (id)weakObjectWithObject:(id)object;
- (BOOL)notNil;
@end
