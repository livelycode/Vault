
#import "LCAppDelegate.h"
#import "LCSettingsStore.h"
#import "LCEncryptedData.h"

@implementation LCAppDelegate {
  BOOL _isLocked;
}

#pragma mark - Class
+ (LCAppDelegate *)sharedAppDelegate {
  return [UIApplication sharedApplication].delegate;
}

#pragma mark - Overridden
- (id)init {
  self = [super init];
  if (self != nil) {
    _isLocked = NO;
  }
  return self;
}

#pragma mark - Locking
- (void)lock {
  if (!_isLocked) {
    [self presentInitialViewControllerFromStoryboardWithName:@"Lock" animated:NO];
    _isLocked = YES;
  }
}

- (void)unlock {
  if (_isLocked) {
    [[self topViewController] dismissViewControllerAnimated:YES completion:nil];
    _isLocked = NO;
  }
}

#pragma mark - UIApplicationDelegate
- (void)applicationDidBecomeActive:(UIApplication *)application {
  [self lock];
  if (![LCSettingsStore sharedSettingsStore].setupCompleted) {
    [self presentInitialViewControllerFromStoryboardWithName:@"Setup" animated:YES];
  }
}

- (void)applicationWillResignActive:(UIApplication *)application {
  [self lock];
}

#pragma mark - Private
- (UIViewController *)topViewController {
  id rootViewController = self.window.rootViewController;
  return [rootViewController visibleViewController];
}

- (void)presentInitialViewControllerFromStoryboardWithName:(NSString *)name animated:(BOOL)animated {
  UIViewController *viewController = [[UIStoryboard storyboardWithName:name bundle:nil] instantiateInitialViewController];
  [[self topViewController] presentViewController:viewController animated:animated completion:nil];
}
@end
