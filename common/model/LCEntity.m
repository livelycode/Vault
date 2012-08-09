
#import "LCEntity.h"
@interface LCEntity()
@property (readwrite, strong) NSString *objectID;
- (id)initWithID:(NSString *)objectID;
@end

@implementation LCEntity
@synthesize objectID;

+ (id)objectWithID:(NSString *)objectID data:(NSData *)data store:(LCStore *)store {
  id object = [[self alloc] initWithID:objectID];
  [object deserializeWithData:data store:store];
  return object;
}

- (id)init {
  return [self initWithID:[[NSUUID UUID] UUIDString]];
}

- (id)initWithID:(NSString *)anObjectID {
  self = [super init];
  if (self != nil) {
    self.objectID = anObjectID;
  }
  return self;
}

- (NSData *)serialize {
  return nil;
}

- (void)deserializeWithData:(NSData *)data store:(LCStore *)store{
  
}

@end
