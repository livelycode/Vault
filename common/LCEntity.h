
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCStore.h"
#import "LCEventEmitter.h"

@class LCStore, LCEventEmitter, LCEntity;

typedef void(^LCDoneHandler)();
typedef void(^LCEntityReadHandler)(id object);
typedef void(^LCEntityUpdateHandler)(id object, LCDoneHandler done);

@protocol LCEntityObserver <NSObject>
@optional
- (void)updatedEntity:(LCEntity *)entity;
- (void)deletedEntity:(LCEntity *)entity;
@end

@interface LCEntity : NSObject <LCDataObserver, NSCoding, NSKeyedUnarchiverDelegate>
@property (readonly) NSUUID *objectID;
+ (id)entityWithObject:(id <NSCoding>)object store:(LCStore *)store;
- (void)addObserver:(id <LCEntityObserver>)observer;
- (void)removeObserver:(id <LCEntityObserver>)observer;
- (void)readObject:(LCEntityReadHandler)handler;
- (void)updateObject:(LCEntityUpdateHandler)handler;
- (void)deleteObject;
- (void)uncacheObject;
@end

@interface LCEntityEvents : LCEventEmitter <LCEntityObserver>
- (void)onUpdate:(LCNotifyBlock)handler;
- (void)onDelete:(LCNotifyBlock)handler;
@end