
#import "LCLockController.h"

@implementation LCLockController
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  [[LCAppDelegate sharedAppDelegate] unlock];
  return NO;
}
@end
