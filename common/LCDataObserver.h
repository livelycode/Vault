
#import <Foundation/Foundation.h>

@class LCStore;

@protocol LCDataObserver <NSObject>
- (void)updated;
- (void)deleted;
@end
