
#import "LCAppearance.h"

@implementation LCAppearance
+ (void)setNavigationBarAppearance {
  UINavigationBar *proxy = [UINavigationBar appearance];
  UIImage *image = [UIImage imageNamed:@"NavigationBar"];
  [proxy setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

+ (void)setBarButtonItemAppearance {
  UIBarButtonItem *proxy = [UIBarButtonItem appearance];
  [proxy setTintColor:[UIColor colorWithRed:(143.0/255.0) green:(154.0/255.0) blue:(159.0/255.0) alpha:1.0]];
}

+ (CALayer *)gradientLayerWithFrame:(CGRect)frame {
  UIColor *topColor = [UIColor colorWithWhite:(220.0/255.0) alpha:1.0];
  UIColor *bottomColor = [UIColor colorWithWhite:(140.0/255.0) alpha:1.0];
  CAGradientLayer *layer = [CAGradientLayer layer];
  layer.frame = frame;
  layer.colors = @[(id)topColor.CGColor, (id)bottomColor.CGColor];
  return layer;
}

+ (CALayer *)grainLayerWithFrame:(CGRect)frame {
  CALayer *layer = [CALayer layer];
  layer.frame = frame;
  layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Grain"]].CGColor;
  layer.opacity = 8.0/255.0;
  return layer;
}
@end
