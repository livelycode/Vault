
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <Security/Security.h>

@interface LCEncryptedData : NSObject <NSCoding>
+ (id)encryptedDataWithData:(NSData *)data password:(NSString *)password;
- (NSData *)decryptWithPassword:(NSString *)password;
@end
