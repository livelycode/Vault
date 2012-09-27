
typedef NS_ENUM(NSUInteger, LCGradientViewType) {
  LCGradientViewTypeLinear,
  LCGradientViewTypeRadial
};

@interface LCGradientView : UIView
@property(readwrite, assign, nonatomic) LCGradientViewType type;
@end
