
#import <UIKit/UIKit.h>

@interface LCAppDelegate : UIResponder <UIApplicationDelegate>
@property(readwrite, strong, nonatomic) UIWindow *window;
+ (LCAppDelegate *)sharedAppDelegate;
- (void)lock;
- (void)unlock;
@end
