//
//  DMMainMenu.m
//  DaftMan
//
//  Created by Tanner Smith on 12/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMMainMenuScene.h"

#import "NSString+DMFontPadding.h"
#import "DMDaftColor.h"
#import "DMMusicPlayer.h"

@implementation DMMainMenuScene

#define FONT @"ARCADECLASSIC"
#define TITLE_FONT_SIZE 72
#define FONT_SIZE 26
#define FONT_COLOR [NSColor whiteColor]

#define EDGE_PADDING 46
#define PADDING 45

@synthesize titleLabel, playLabel, copyrightLabel;
@synthesize delegate;

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [NSColor blackColor];
        
        titleLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
        titleLabel.fontSize = TITLE_FONT_SIZE;
        titleLabel.fontColor = FONT_COLOR;
        
        playLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
        playLabel.fontSize = FONT_SIZE;
        playLabel.fontColor = FONT_COLOR;
        
        copyrightLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
        copyrightLabel.fontSize = FONT_SIZE;
        copyrightLabel.fontColor = FONT_COLOR;
        
        titleLabel.text = [NSString stringByPaddingString:@"DaftMan"];
        playLabel.text = [NSString stringByPaddingString:@"Press Enter to Play"];
        copyrightLabel.text = [NSString stringByPaddingString:@"2010 Ryan Ashcraft"];
        
        [self addChild:titleLabel];
        [self addChild:playLabel];
        [self addChild:copyrightLabel];
        
        titleLabel.position = CGPointMake(size.width / 2, size.height - EDGE_PADDING);
        titleLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        playLabel.position = CGPointMake(size.width / 2, size.height - EDGE_PADDING - titleLabel.frame.size.height - PADDING);
        playLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        playLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        copyrightLabel.position = CGPointMake(size.width / 2, EDGE_PADDING);
        copyrightLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
        copyrightLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        [titleLabel runAction:[DMDaftColor actionForLabel:titleLabel]];
        
        NSString *midiFilePath = [[NSBundle mainBundle] pathForResource:@"dafunk" ofType:@"mid"];
        NSURL *midiFileURL = [NSURL fileURLWithPath:midiFilePath];
        
        [[DMMusicPlayer sharedMusicPlayer] playSequence:midiFileURL beatsPerMinute:120];
    }
    
    return self;
}

- (void)keyDown:(NSEvent *)theEvent {
    if (theEvent.isARepeat == NO && [[theEvent charactersIgnoringModifiers] characterAtIndex:0] == NSCarriageReturnCharacter) {
        [delegate nextLevel:1 startingScore:0];
    }
}

@end
