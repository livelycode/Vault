
#import "LCCryptor.h"

NSData *LCCryptorSalt(void) {
  return nil;
}

NSData *LCCryptorInitializationVector(void) {
  return nil;
}

NSData *LCCryptorEncryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector) {
  return nil;
}

NSData *LCCryptorDecryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector) {
  return nil;
}

NSData *LCCryptorAES256KeyWithPasswordSalt(NSString *password, NSData *salt) {
  uint8_t buffer[kCCKeySizeAES256];
  const char *passwordBytes = [password UTF8String];
  size_t passwordLength = [password lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
  const uint8_t *saltBytes = [salt bytes];
  size_t saltLength = [salt length];
  uint rounds = CCCalibratePBKDF(kCCPBKDF2, passwordLength, saltLength, kCCPRFHmacAlgSHA1, kCCKeySizeAES256, 1);
  CCKeyDerivationPBKDF(kCCPBKDF2, passwordBytes, passwordLength, saltBytes, saltLength, kCCPRFHmacAlgSHA1, rounds, buffer, kCCKeySizeAES256);
  return [NSData dataWithBytes:buffer length:kCCKeySizeAES256];
}

NSData *LCCryptorEncryptDataWithPasswordSaltInitializationVector(NSData *data, NSString *password, NSData *salt, NSData *vector) {
  NSMutableData *encryptedData = [NSMutableData dataWithCapacity:data.length];
  NSData *key = LCCryptorAES256KeyWithPasswordSalt(password, salt);
  const void *keyBytes = [key bytes];
  const void *dataBytes = [data bytes];
  size_t dataLength = [data length];
  size_t dataOutMoved = 0;
  CCCryptorStatus result = CCCrypt(kCCEncrypt,
                                   kCCAlgorithmAES128,
                                   kCCOptionPKCS7Padding,
                                   keyBytes,
                                   kCCKeySizeAES256,
                                   vector.bytes, // ?
                                   dataBytes,
                                   dataLength,
                                   encryptedData.mutableBytes, // ?
                                   encryptedData.length, // ?
                                   &dataOutMoved); // ?
  return nil;
}
