
#import "LCWindowController.h"
#import "LCCategoryListController.h"
#import "LCEntryListController.h"

@implementation LCWindowController {
  IBOutlet LCCategoryListController *categoryListController;
  IBOutlet LCEntryListController *entryListController;
}

- (BOOL)validateUserInterfaceItem:(id <NSValidatedUserInterfaceItem>)anItem {
  SEL action = anItem.action;
  if ((action == @selector(editCategory:)) || (action == @selector(removeCategory:))) {
    return YES;
  }
  if ((action == @selector(editEntry:)) || (action == @selector(removeEntry:))) {
    return YES;
  }
  return YES;
}

- (void)addCategory:(id)sender {
  
}

- (void)removeCategory:(id)sender {
  
}

- (void)editCategory:(id)sender {
  
}

- (void)addEntry:(id)sender {
  
}

- (void)removeEntry:(id)sender {
  
}

- (void)editEntry:(id)sender {
  
}

@end
