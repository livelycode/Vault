
#import "LCLockController.h"
#import "LCSettingsStore.h"
#import "LCAppearance.h"

@implementation LCLockController
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  LCEncryptedData *encryptedPassword = [LCSettingsStore sharedSettingsStore].encryptedPassword;
  if ([encryptedPassword isEqualToPassword:textField.text]) {
    [[LCAppDelegate sharedAppDelegate] unlock];
  } else {
    textField.text = nil;
    [[[UIAlertView alloc] initWithTitle:@"foo" message:@"bar" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  }
  return NO;
}

#pragma mark - Overridden
- (void)viewDidLoad {
  CALayer *superLayer = self.view.layer;
  CALayer *gradientLayer = [LCAppearance gradientLayerWithFrame:superLayer.bounds];
  CALayer *grainLayer = [LCAppearance grainLayerWithFrame:superLayer.bounds];
  [superLayer insertSublayer:gradientLayer atIndex:0];
  [superLayer insertSublayer:grainLayer atIndex:1];
}
@end
