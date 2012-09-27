
#import "Utility.h"

@implementation LCGradient
#pragma mark - Class
+ (void)drawLinearGradientInRect:(CGRect)rect {
  CGFloat top = CGRectGetMaxY(rect);
  CGFloat bottom = CGRectGetMinY(rect);
  CGFloat left = CGRectGetMinX(rect);
  CGPoint start = CGPointMake(left, bottom);
  CGPoint end = CGPointMake(left, top);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGGradientRef gradient = LCGradientCreate();
  CGContextSetBlendMode(context, kCGBlendModeSoftLight);
  CGContextDrawLinearGradient(context, gradient, start, end, 0);
  CGGradientRelease(gradient);
}

+ (void)drawRadialGradientInRect:(CGRect)rect {
  CGFloat centerX = CGRectGetMidX(rect);
  CGFloat centerY = CGRectGetMidY(rect);
  CGFloat width = CGRectGetWidth(rect) / 2.0;
  CGFloat height = CGRectGetHeight(rect) / 2.0;
  CGPoint center = CGPointMake(centerX, centerY);
  CGFloat radius = MAX(width, height);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGGradientRef gradient = LCGradientCreate();
  CGContextSetBlendMode(context, kCGBlendModeSoftLight);
  CGContextDrawRadialGradient(context, gradient, center, 0.0, center, radius, kCGGradientDrawsAfterEndLocation);
  CGGradientRelease(gradient);
}

#pragma mark - Private
CGFloat LC8BitValue(CGFloat value) {
  return value / 255.0;
}

CGGradientRef LCGradientCreate(void) {
  CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
  CGFloat alpha = LC8BitValue(140.0);
  CGFloat components[] = {1.0, 1.0, 1.0, alpha, 0.0, 0.0, 0.0, alpha};
  CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, NULL, 2);
  CGColorSpaceRelease(space);
  return gradient;
}
@end
