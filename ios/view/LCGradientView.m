
#import "LCGradientView.h"
#import "LCGradient.h"

@implementation LCGradientView
- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self != nil) {
    _type = LCGradientViewTypeLinear;
  }
  return self;
}

- (void)setType:(LCGradientViewType)type {
  _type = type;
  [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
  [self.backgroundColor set];
  [[UIBezierPath bezierPathWithRect:self.bounds] fill];
  if (_type == LCGradientViewTypeLinear) {
    [LCGradient drawLinearGradientInRect:self.bounds];
  }
  if (_type == LCGradientViewTypeRadial) {
    [LCGradient drawRadialGradientInRect:rect];
  }
}
@end
