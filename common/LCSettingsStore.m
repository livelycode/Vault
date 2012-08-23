
#import "LCSettingsStore.h"

#pragma mark Class state
LCSettingsStore *singleton = nil;

#pragma mark - NSUserDefault keys
NSString *LCSetupCompletedKey = @"LCSetupCompleted";

@implementation LCSettingsStore
#pragma mark - Class
+ (LCSettingsStore *)sharedSettingsStore {
  if (singleton == nil) {
    singleton = [[self alloc] init];
  }
  return singleton;
}

#pragma mark - Overriden
- (id)init {
  self = [super init];
  if (self != nil) {
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{LCSetupCompletedKey:@NO}];
  }
  return self;
}

#pragma mark - Properties
- (BOOL)setupCompleted {
  return [[NSUserDefaults standardUserDefaults] boolForKey:LCSetupCompletedKey];
}

- (void)setSetupCompleted:(BOOL)setupCompleted {
  [[NSUserDefaults standardUserDefaults] setBool:setupCompleted forKey:LCSetupCompletedKey];
}
@end
