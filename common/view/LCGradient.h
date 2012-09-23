
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LCGradient : NSObject
+ (void)drawLinearGradientInRect:(CGRect)rect;
+ (void)drawRadialGradientInRect:(CGRect)rect;
@end
