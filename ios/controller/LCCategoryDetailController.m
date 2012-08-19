
#import "LCCategoryDetailController.h"

@interface LCCategoryDetailController()
- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
@end

@implementation LCCategoryDetailController
#pragma mark - Overriden
- (void)viewDidLoad {
  [super viewDidLoad];
  if (self.modalMode) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
  }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FieldCell" forIndexPath:indexPath];
  return cell;
}

#pragma mark - Actions
- (IBAction)save:(id)sender {
  if (self.modalMode) {
    [self dismissViewControllerAnimated:YES completion:nil];
  } else {
    [self.navigationController popViewControllerAnimated:YES];
  }
}

- (IBAction)cancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
