
#import "LCCryptor.h"

#pragma mark - Private
NSData *LCCryptorAES256Key(NSString *password, NSData *salt) {
  NSMutableData *key = [NSMutableData dataWithLength:kCCKeySizeAES256];
  const char *passwordBytes = [password UTF8String];
  size_t passwordLength = [password lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
  const uint8_t *saltBytes = [salt bytes];
  size_t saltLength = [salt length];
  uint rounds = 1024;
  uint8_t *buffer = [key mutableBytes];
  int result = CCKeyDerivationPBKDF(kCCPBKDF2, passwordBytes, passwordLength, saltBytes, saltLength, kCCPRFHmacAlgSHA1, rounds, buffer, kCCKeySizeAES256);
  NSCAssert(result == kCCSuccess, @"AES-256 key creation failed");
  return key;
}

NSData *LCCryptorCryptData(CCOperation operation, NSData *data, NSString *password, NSData *salt, NSData *initializationVector) {
  NSData *key = LCCryptorAES256Key(password, salt);
  const void *keyBytes = [key bytes];
  const void *ivBytes = [initializationVector bytes];
  const void *dataBytes = [data bytes];
  size_t dataLength = [data length];
  size_t bufferLength = dataLength + kCCBlockSizeAES128;
  NSMutableData *cryptedData = [NSMutableData dataWithLength:bufferLength];
  void *buffer = [cryptedData mutableBytes];
  size_t written = 0;
  CCCryptorStatus result = CCCrypt(operation, kCCAlgorithmAES128, kCCOptionPKCS7Padding, keyBytes, kCCKeySizeAES256, ivBytes, dataBytes, dataLength, buffer, bufferLength, &written);
  NSCAssert(result == kCCSuccess, @"Encrytion/Decryption failed");
  [cryptedData setLength:written];
  return cryptedData;
}

#pragma mark - Public
NSData *LCCryptorRandomData(LCCryptorRandomLength length) {
  NSMutableData *data = [NSMutableData dataWithLength:length];
  uint8_t *buffer = [data mutableBytes];
  int result = SecRandomCopyBytes(kSecRandomDefault, length, buffer);
  NSCAssert(result == 0, @"Random Data generation failed");
  return data;
}

NSData *LCCryptorEncryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector) {
  return LCCryptorCryptData(kCCEncrypt, data, password, salt, initializationVector);
}

NSData *LCCryptorDecryptData(NSData *data, NSString *password, NSData *salt, NSData *initializationVector) {
  return LCCryptorCryptData(kCCDecrypt, data, password, salt, initializationVector);
}
