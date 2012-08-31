
#import "LCStorageSetupController.h"
#import "LCSettingsStore.h"

@implementation LCStorageSetupController {
  IBOutlet UISwitch *_iCloudSwitch;
}

- (IBAction)saveSettings:(id)sender {
  [LCSettingsStore sharedSettingsStore].cloudStorage = _iCloudSwitch.on;
}
@end
