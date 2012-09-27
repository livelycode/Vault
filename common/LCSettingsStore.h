
@class LCEncryptedData;

@interface LCSettingsStore : NSObject
+ (LCSettingsStore *)sharedSettingsStore;
@property(readwrite, assign, nonatomic) BOOL setupCompleted;
@property(readwrite, assign, nonatomic) BOOL cloudStorage;
@property(readwrite, strong, nonatomic) LCEncryptedData *encryptedPassword;
@end
