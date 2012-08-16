
#import <UIKit/UIKit.h>
#import "LCAppDelegate.h"

int main(int argc, char *argv[]) {
  @autoreleasepool {
    NSString *className = NSStringFromClass([LCAppDelegate class]);
    return UIApplicationMain(argc, argv, nil, className);
  }
}
