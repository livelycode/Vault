
#import "LCWeakObject.h"

@implementation LCWeakObject
+ (id)weakObjectWithObject:(id)object {
  return [[self alloc] initWithObject:object];
}

- (id)initWithObject:(id)object {
  self = [super init];
  if (self != nil) {
    _object = object;
  }
  return self;
}

- (BOOL)notNil {
  return _object != nil;
}

@end
