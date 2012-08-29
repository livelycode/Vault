//
//  LCWindowController.h
//  Vault-osx imac
//
//  Created by Mirko on 8/29/12.
//  Copyright (c) 2012 LivelyCode. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LCWindowController : NSObject
- (IBAction)addCategory:(id)sender;
- (IBAction)removeCategory:(id)sender;
- (IBAction)editCategory:(id)sender;
- (IBAction)addEntry:(id)sender;
- (IBAction)removeEntry:(id)sender;
- (IBAction)editEntry:(id)sender;
@end
