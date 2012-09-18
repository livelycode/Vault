
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LCAppearance : NSObject
+ (void)setThemeAppearance:(BOOL)custom;
+ (void)configureLockView:(UIView *)view;
+ (void)configureSetupView:(UITableView *)view;
@end
