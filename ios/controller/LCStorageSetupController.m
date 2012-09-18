
#import "LCStorageSetupController.h"
#import "LCSettingsStore.h"
#import "LCAppearance.h"

@implementation LCStorageSetupController {
  IBOutlet UITableViewCell *_cloudCell;
}

- (void)viewDidLoad {
  _cloudCell.accessoryView = [[UISwitch alloc] initWithFrame:CGRectZero];
  NSLog(@"%@", self.tableView.backgroundView);
  [LCAppearance configureSetupView:self.tableView];
}

- (IBAction)saveSettings:(id)sender {
  id cloudSwitch = _cloudCell.accessoryView;
  [LCSettingsStore sharedSettingsStore].cloudStorage = [cloudSwitch isOn];
}
@end
