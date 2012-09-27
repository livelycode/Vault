
#import "Controller.h"
#import "Store.h"

@implementation LCLockController
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  LCEncryptedData *encryptedPassword = [LCSettingsStore sharedSettingsStore].encryptedPassword;
  if ([encryptedPassword isEqualToPassword:textField.text]) {
    [[LCWindowController sharedAppDelegate] unlock];
  } else {
    textField.text = nil;
    [[[UIAlertView alloc] initWithTitle:@"foo" message:@"bar" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  }
  return NO;
}
@end
