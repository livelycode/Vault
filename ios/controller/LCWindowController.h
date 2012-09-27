
@interface LCWindowController : UIResponder <UIApplicationDelegate>
@property(readwrite, strong, nonatomic) UIWindow *window;
+ (LCWindowController *)sharedAppDelegate;
- (void)lock;
- (void)unlock;
@end
