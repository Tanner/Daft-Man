//
//  DMAppDelegate.m
//  DaftMan
//
//  Created by Tanner Smith on 11/11/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMAppDelegate.h"

@implementation DMAppDelegate

@synthesize sceneDirector;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    CGSize size = CGSizeMake(16 * 32, 100 + 12 * 32);
    
    sceneDirector = [[DMSceneDirector alloc] initWithSize:size view:self.skView];

    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

@end
