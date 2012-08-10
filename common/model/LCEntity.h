
#import <Foundation/Foundation.h>
#import "LCEntityProtocol.h"

@interface LCEntity : NSObject <LCEntity>
+ (id)entityWithStore:(LCStore *)store;
@end
