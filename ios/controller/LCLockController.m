
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
  [LCAppearance configureLockView:self.view];
}
@end
