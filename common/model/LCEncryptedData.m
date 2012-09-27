
#import "Store.h"

@implementation LCEncryptedData {
  NSData *_salt;
  NSData *_initializationVector;
  NSData *_ciphertext;
}
#pragma mark - Keys
NSString *LCEncryptedDataSaltKey = @"LCEncryptedDataSalt";
NSString *LCEncryptedDataInitializationVectorKey = @"LCEncryptedDataInitializationVector";
NSString *LCEncryptedDataCiphertextKey = @"LCEncryptedCiphertext";

#pragma mark - Class
+ (id)encryptedDataWithData:(NSData *)data password:(NSString *)password {
  NSData *salt = LCEncryptedDataRandomData(16);
  return [[self alloc] initWithData:data password:password salt:salt];
}

+ (id)encryptedDataWithPassword:(NSString *)password {
  NSData *salt = LCEncryptedDataRandomData(16);
  NSData *hash = LCEncryptedDataKey(password, salt);
  return [[self alloc] initWithData:hash password:password salt:salt];
}

#pragma mark - Decryption
- (BOOL)isEqualToPassword:(NSString *)password {
  NSData *hash = LCEncryptedDataKey(password, _salt);
  NSData *decryptedHash = [self decryptWithPassword:password];
  return [hash isEqualToData:decryptedHash];
}

- (NSData *)decryptWithPassword:(NSString *)password {
  return LCEncryptedDataCryptData(kCCDecrypt, _ciphertext, password, _salt, _initializationVector);
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)coder {
  [coder encodeObject:_salt forKey:LCEncryptedDataSaltKey];
  [coder encodeObject:_initializationVector forKey:LCEncryptedDataInitializationVectorKey];
  [coder encodeObject:_ciphertext forKey:LCEncryptedDataCiphertextKey];
}

- (id)initWithCoder:(NSCoder *)coder {
  self = [super init];
  if (self != nil) {
    _salt = [coder decodeObjectForKey:LCEncryptedDataSaltKey];
    _initializationVector = [coder decodeObjectForKey:LCEncryptedDataInitializationVectorKey];
    _ciphertext = [coder decodeObjectForKey:LCEncryptedDataCiphertextKey];
  }
  return self;
}

#pragma mark - Private
- (id)initWithData:(NSData *)data password:(NSString *)password salt:(NSData *)salt {
  self = [super init];
  if (self != nil) {
    _salt = salt;
    _initializationVector = LCEncryptedDataRandomData(kCCBlockSizeAES128);
    _ciphertext = LCEncryptedDataCryptData(kCCEncrypt, data, password, _salt, _initializationVector);
  }
  return self;
}

NSData *LCEncryptedDataRandomData(size_t length) {
  NSMutableData *data = [NSMutableData dataWithLength:length];
  uint8_t *buffer = [data mutableBytes];
  int result = SecRandomCopyBytes(kSecRandomDefault, length, buffer);
  NSCAssert(result == 0, @"Random Data generation failed");
  return data;
}

NSData *LCEncryptedDataKey(NSString *password, NSData *salt) {
  NSMutableData *key = [NSMutableData dataWithLength:kCCKeySizeAES256];
  const char *passwordBytes = [password UTF8String];
  size_t passwordLength = [password lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
  const uint8_t *saltBytes = [salt bytes];
  size_t saltLength = [salt length];
  uint rounds = 8192;
  uint8_t *buffer = [key mutableBytes];
  int result = CCKeyDerivationPBKDF(kCCPBKDF2, passwordBytes, passwordLength, saltBytes, saltLength, kCCPRFHmacAlgSHA512, rounds, buffer, kCCKeySizeAES256);
  NSCAssert(result == kCCSuccess, @"AES-256 key creation failed");
  return key;
}

NSData *LCEncryptedDataCryptData(CCOperation operation, NSData *data, NSString *password, NSData *salt, NSData *initializationVector) {
  NSData *key = LCEncryptedDataKey(password, salt);
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
@end


