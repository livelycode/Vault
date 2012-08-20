
#import "LCLockController.h"

@implementation LCLockController
+ (id)instantiateFromStoryboard {
  return [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"LCLockController"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [LCAppDelegate sharedAppDelegate].isLocked = NO;
  [self dismissViewControllerAnimated:YES completion:nil];
  return NO;
}
@end
