
#import "LCStorageSetupController.h"
#import "LCSettingsStore.h"
#import "LCAppearance.h"

@implementation LCStorageSetupController {
  IBOutlet UITableViewCell *_cloudCell;
}

- (void)viewDidLoad {
  self.tableView.backgroundView = [LCAppearance setupBackgroundView];
  _cloudCell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
}

- (IBAction)saveSettings:(id)sender {
  id cloudSwitch = _cloudCell.accessoryView;
  [LCSettingsStore sharedSettingsStore].cloudStorage = [cloudSwitch isOn];
}
@end
