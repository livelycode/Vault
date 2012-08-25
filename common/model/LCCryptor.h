
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

NSData *LCCryptorSalt(void);
NSData *LCCryptorInitializationVector(void);
NSData *LCCryptorEncryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector);
NSData *LCCryptorDecryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector);
