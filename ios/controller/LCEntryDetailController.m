
#import "LCEntryDetailController.h"

@implementation LCEntryDetailController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FieldCell" forIndexPath:indexPath];
  return cell;
}
@end
