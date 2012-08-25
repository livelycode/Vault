
#import "LCPasswordSetupController.h"
#import "LCSettingsStore.h"

@implementation LCPasswordSetupController {
  IBOutlet UITextField *_passwordField;
  IBOutlet UITextField *_verificationField;
}
#pragma mark - Overridden
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
}

#pragma mark - Actions
- (IBAction)finishSetup:(id)sender {
  [LCSettingsStore sharedSettingsStore].setupCompleted = YES;
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
