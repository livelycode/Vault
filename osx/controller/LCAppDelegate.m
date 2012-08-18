//
//  LCAppDelegate.m
//  Vault
//
//  Created by Mirko on 8/3/12.
//  Copyright (c) 2012 LivelyCode. All rights reserved.
//

#import "LCAppDelegate.h"
#import "LCStore.h"

@implementation LCAppDelegate {
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  id currentiCloudToken = [[NSFileManager defaultManager] ubiquityIdentityToken];
  if (currentiCloudToken) {
    NSData *newTokenData =
    [NSKeyedArchiver archivedDataWithRootObject: currentiCloudToken];
    [[NSUserDefaults standardUserDefaults]
     setObject: newTokenData
     forKey: @"com.apple.CloudNotes.UbiquityIdentityToken"];
  } else {
    [[NSUserDefaults standardUserDefaults]
     removeObjectForKey: @"com.apple.CloudNotes.UbiquityIdentityToken"];
  }
  BOOL firstLaunchWithiCloudAvailable = YES;
  if (currentiCloudToken && firstLaunchWithiCloudAvailable) {
    NSAlert *alert = [NSAlert alertWithMessageText:@"Choose Storage Option" defaultButton:@"iCloud" alternateButton:@"Local Only" otherButton:nil informativeTextWithFormat:@"Should documents be stored in iCloud and available on all your devices?"];
    [alert runModal];
  }
}

@end
