
#import <Foundation/Foundation.h>

@protocol LCManagedObject <NSObject>
@required
@property (readonly, weak) NSUUID *objectID;
@property (readonly, weak) NSData *data;
- (void)updateWithData:(NSData *)data;
@end
