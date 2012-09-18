
#import "LCAppearance.h"

@implementation LCAppearance
#pragma mark - Class
+ (void)setThemeAppearance:(BOOL)custom {
  if (custom) {
    UINavigationBar *barProxy = [UINavigationBar appearance];
    UIBarButtonItem *buttonProxy = [UIBarButtonItem appearance];
    UIImage *image = [UIImage imageNamed:@"NavigationBar"];
    [barProxy setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [buttonProxy setTintColor:LCColor8Bit(143, 154, 159)];
  } else {
    
  }
}

+ (void)configureLockView:(UIView *)view {
  CALayer *superLayer = view.layer;
  CALayer *gradientLayer = LCGradientLayerWithFrame(superLayer.bounds);
  CALayer *grainLayer = LCGrainLayerWithFrame(superLayer.bounds);
  [superLayer insertSublayer:gradientLayer atIndex:0];
  [superLayer insertSublayer:grainLayer atIndex:1];
}

+ (void)configureSetupView:(UITableView *)view {

}

#pragma mark - Private
UIColor *LCColor8Bit(NSUInteger red, NSUInteger green, NSUInteger blue) {
  return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:1.0];
}

UIColor *LCColorWhite8Bit(NSUInteger white) {
  return [UIColor colorWithWhite:(white/255.0) alpha:1.0];
}

CAGradientLayer *LCGradientLayerWithFrame(CGRect frame) {
  UIColor *topColor = LCColorWhite8Bit(220);
  UIColor *bottomColor = LCColorWhite8Bit(140);
  CAGradientLayer *layer = [CAGradientLayer layer];
  layer.frame = frame;
  layer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
  return layer;
}

CALayer *LCGrainLayerWithFrame(CGRect frame) {
  CALayer *layer = [CALayer layer];
  layer.frame = frame;
  layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Grain"]].CGColor;
  layer.opacity = 8.0/255.0;
  return layer;
}
@end
