
#import "LCAppearance.h"
#import "LCGradientView.h"

@implementation LCAppearance
#pragma mark - Class
+ (UIView *)setupBackgroundView {
  LCGradientView *backgroundView = [[LCGradientView alloc] initWithFrame:CGRectZero];
  backgroundView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
  backgroundView.type = LCGradientViewTypeRadial;
  return backgroundView;
}
@end
