
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import <Security/Security.h>

typedef NS_ENUM(size_t, LCCryptorRandomLength) {
  LCCryptorRandomLengthSalt = 8,
  LCCryptorRandomLengthInitializationVector = kCCBlockSizeAES128
};

NSData *LCCryptorRandomData(LCCryptorRandomLength length);
NSData *LCCryptorEncryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector);
NSData *LCCryptorDecryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector);
