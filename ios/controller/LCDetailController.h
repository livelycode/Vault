
#import <UIKit/UIKit.h>

@interface LCDetailController : UITableViewController
@property(readwrite, assign, nonatomic) BOOL modalMode;
@end

@interface UIViewController(LC)
@property(readwrite, assign, nonatomic) BOOL modalMode;
@end