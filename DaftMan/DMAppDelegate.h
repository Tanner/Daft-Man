//
//  DMAppDelegate.h
//  DaftMan
//

//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <SpriteKit/SpriteKit.h>

#import "DMSceneDirector.h"

@interface DMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet SKView *skView;

@property (nonatomic, retain) DMSceneDirector *sceneDirector;

@end
