//
//  LCCategoryList.m
//  Vault-osx imac
//
//  Created by Mirko on 8/10/12.
//  Copyright (c) 2012 LivelyCode. All rights reserved.
//

#import "LCCategoryListController.h"
#import "LCEntity.h"
#import "LCStore.h"
#import "LCCategoryList.h"
#import "LCAppStore.h"

@implementation LCCategoryListController {
  IBOutlet NSTableView *_tableView;
  LCEntity *_categoryListEntity;
  LCCategoryList *_categoryList;
}

- (id)initWithCoder:(NSCoder *)coder {
  self = [super init];
  if (self) {
    _categoryListEntity = [[LCAppStore store] categoryList];
    [self reloadData];
  }
  return self;
}

- (void)awakeFromNib {
  [_tableView setRowHeight:30];
  [_categoryListEntity addObserver:self];
}

- (void)reloadData {
  [_categoryListEntity readObject:^(LCCategoryList *categoryList) {
    _categoryList = categoryList;
    [_tableView reloadData];
  }];
}

/*
 NSTableViewDelegate protocol
*/

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  CGRect rect = CGRectMake(0, 0, 100, 100);
  NSTextField *text = [[NSTextField alloc] initWithFrame:NSRectFromCGRect(rect)];
  LCEntity *categoryEntity = _categoryList.categories[row];
  [categoryEntity readObject:^(LCCategory *category) {
    [text setStringValue:category.name];
  }];
  return text;
}

/*
 NSTableViewDataSource protocol
*/

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return [_categoryList.categories count];
}

/*
 NSEntityObserver protocol
*/

- (void)updatedEntity:(LCEntity *)entity {
  [self reloadData];
}

@end
