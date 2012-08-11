//
//  LCAppDelegate.h
//  Vault
//
//  Created by Mirko on 8/3/12.
//  Copyright (c) 2012 LivelyCode. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LCStore;

@interface LCAppDelegate : NSObject <NSApplicationDelegate>
@property (readonly) LCStore *store;
@property (assign) IBOutlet NSWindow *window;

@end
