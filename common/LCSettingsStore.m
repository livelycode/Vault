
#import "LCSettingsStore.h"

@implementation LCSettingsStore
#pragma mark Class state
LCSettingsStore *singleton = nil;

#pragma mark - NSUserDefault keys
NSString *LCSetupCompletedKey = @"LCSetupCompleted";
NSString *LCCloudStorageKey = @"LCCloudStorage";
NSString *LCEncryptedPasswordKey = @"LCEncryptedPasswordKey";

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

- (BOOL)cloudStorage {
  return [[NSUserDefaults standardUserDefaults] boolForKey:LCCloudStorageKey];
}

- (void)setCloudStorage:(BOOL)cloudStorage {
  [[NSUserDefaults standardUserDefaults] setBool:cloudStorage forKey:LCCloudStorageKey];
}

- (LCEncryptedData *)encryptedPassword {
  NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:LCEncryptedPasswordKey];
  return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)setEncryptedPassword:(LCEncryptedData *)encryptedPassword {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:encryptedPassword];
  [[NSUserDefaults standardUserDefaults] setObject:data forKey:LCEncryptedPasswordKey];
}
@end
