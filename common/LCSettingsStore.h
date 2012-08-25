
#import <Foundation/Foundation.h>

@interface LCSettingsStore : NSObject
+ (LCSettingsStore *)sharedSettingsStore;
@property(readwrite, assign, nonatomic) BOOL setupCompleted;
@property(readwrite, assign, nonatomic) BOOL cloudStorage;
@end
