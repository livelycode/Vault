
#import <UIKit/UIKit.h>

@interface LCAppDelegate : UIResponder <UIApplicationDelegate>
@property(readwrite, strong, nonatomic) UIWindow *window;
@property(readwrite, assign, nonatomic) BOOL isLocked;
+ (LCAppDelegate *)sharedAppDelegate;
@end
