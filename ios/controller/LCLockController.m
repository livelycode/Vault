
#import "LCLockController.h"
#import "LCSettingsStore.h"

@implementation LCLockController
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  LCEncryptedData *encryptedPassword = [LCSettingsStore sharedSettingsStore].encryptedPassword;
  if ([encryptedPassword isEqualToPassword:textField.text]) {
    [[LCAppDelegate sharedAppDelegate] unlock];
  } else {
    textField.text = nil;
    [[[UIAlertView alloc] initWithTitle:@"foo" message:@"bar" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
  }
  return NO;
}

#pragma mark - Overridden
- (void)viewDidLoad {
  CALayer *layer = self.view.layer;
  [layer insertSublayer:LCGradient(layer.bounds) atIndex:0];
  [layer insertSublayer:LCGrain(layer.bounds) atIndex:1];
}

#pragma mark - Private
CAGradientLayer *LCGradient(CGRect frame) {
  UIColor *topColor = [UIColor colorWithWhite:(220.0/255.0) alpha:1.0];
  UIColor *bottomColor = [UIColor colorWithWhite:(140.0/255.0) alpha:1.0];
  CAGradientLayer *layer = [CAGradientLayer layer];
  layer.frame = frame;
  layer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
  return layer;
}

CALayer *LCGrain(CGRect frame) {
  CALayer *layer = [CALayer layer];
  layer.frame = frame;
  layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Grain"]].CGColor;
  layer.opacity = 8.0/255.0;
  return layer;
}
@end
