
#import "LCPasswordSetupController.h"
#import "LCSettingsStore.h"

@implementation LCPasswordSetupController {
  IBOutlet UITextField *_passwordField;
  IBOutlet UITextField *_verificationField;
}

#pragma mark - Actions
- (IBAction)finishSetup:(id)sender {
  LCSettingsStore *settingsStore = [LCSettingsStore sharedSettingsStore];
  settingsStore.encryptedPassword = [LCEncryptedData encryptedDataWithPassword:_passwordField.text];
  settingsStore.setupCompleted = YES;
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)validatePassword:(id)sender {
  BOOL notEmpty = _passwordField.text.length != 0;
  BOOL validVarification = [_verificationField.text isEqualToString:_passwordField.text];
  self.navigationItem.rightBarButtonItem.enabled = notEmpty && validVarification;
}
@end
