
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LCAppearance : NSObject
+ (void)setNavigationBarAppearance;
+ (void)setBarButtonItemAppearance;
+ (CALayer *)gradientLayerWithFrame:(CGRect)frame;
+ (CALayer *)grainLayerWithFrame:(CGRect)frame;
@end
