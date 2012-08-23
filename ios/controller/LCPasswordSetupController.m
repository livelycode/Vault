
#import "LCPasswordSetupController.h"
#import "LCSettingsStore.h"

@implementation LCPasswordSetupController
- (IBAction)finish:(id)sender {
  [LCSettingsStore sharedSettingsStore].setupCompleted = YES;
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
