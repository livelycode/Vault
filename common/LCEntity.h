
#import <Foundation/Foundation.h>
#import "LCUtils.h"
#import "LCEventEmitter.h"

@class LCEventEmitter, LCEntity, LCObjectStore;

typedef void(^LCDoneHandler)(id updatedObject);
typedef void(^LCEntityReadHandler)(id object);
typedef void(^LCEntityUpdateHandler)(id object, LCDoneHandler done);

@protocol LCEntityObserver <NSObject>
@optional
- (void)updatedEntity:(LCEntity *)entity;
- (void)deletedEntity:(LCEntity *)entity;
@end

@interface LCEntity : NSObject <LCKeyObserver, NSCoding>
@property (readonly) NSUUID *objectID;
@property (readwrite) LCObjectStore *store;
+ (id)entityWithID:(NSUUID *)objectID store:(LCObjectStore *)store;
+ (id)entityWithObject:(id <NSCoding>)object store:(LCObjectStore *)store;
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