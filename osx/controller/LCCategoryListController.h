//
//  LCCategoryList.h
//  Vault-osx imac
//
//  Created by Mirko on 8/10/12.
//  Copyright (c) 2012 LivelyCode. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LCEntity.h"

@class LCCategory;

@interface LCCategoryListController : NSObject <NSTableViewDelegate, NSTableViewDataSource, LCEntityObserver> {
  IBOutlet LCCategory *selectedCategory;
}
@end
