
#import "LCEntryController.h"
#import "LCEntryDetailController.h"

@implementation LCEntryController
#pragma mark - Overriden
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"EntryDetailModalSegue"]) {
    id detailController = [segue.destinationViewController topViewController];
    [detailController setModalMode:YES];
  }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell" forIndexPath:indexPath];
  return cell;
}
@end
