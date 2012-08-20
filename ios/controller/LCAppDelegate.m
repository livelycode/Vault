
#import "LCAppDelegate.h"
#import "LCLockController.h"

@implementation LCAppDelegate
+ (LCAppDelegate *)sharedAppDelegate {
  return [UIApplication sharedApplication].delegate;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [self lock];
}

- (void)applicationWillResignActive:(UIApplication *)application {
  [self lock];
}

- (void)lock {
  if (!self.isLocked) {
    LCLockController *lockController = [LCLockController instantiateFromStoryboard];
    id rootController = self.window.rootViewController;
    [[rootController visibleViewController] presentViewController:lockController animated:NO completion:nil];
    self.isLocked = YES;
  }
}
@end
