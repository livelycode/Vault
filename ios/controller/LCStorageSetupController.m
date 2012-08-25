
#import "LCStorageSetupController.h"
#import "LCSettingsStore.h"

@implementation LCStorageSetupController {
  IBOutlet UISwitch *_iCloudSwitch;
}

#pragma mark - Overridden
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
}

- (IBAction)saveSettings:(id)sender {
  [LCSettingsStore sharedSettingsStore].cloudStorage = _iCloudSwitch.on;
}
@end
