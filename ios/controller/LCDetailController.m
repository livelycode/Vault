
#import "LCDetailController.h"

@implementation LCDetailController
#pragma mark - Overriden
- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.modalMode) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
  }
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)];
}

- (void)save:(id)sender {
  if (self.modalMode) {
    [self dismissViewControllerAnimated:YES completion:nil];
  } else {
    [self.navigationController popViewControllerAnimated:YES];
  }
}

- (void)cancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
