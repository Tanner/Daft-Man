//
//  DMEndScene.m
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMEndScene.h"

#import "NSString+DMFontPadding.h"

@implementation DMEndScene

#define FONT @"ARCADECLASSIC"
#define FONT_SIZE 26
#define FONT_COLOR [NSColor whiteColor]

#define PADDING 9

#define TIME_SHOWN 10

@synthesize titleLabel, scoreLabel;
@synthesize lineThreeLabel, lineFourLabel;
@synthesize delegate;
@synthesize win, score, level;
@synthesize firstUpdate, startTime;

- (id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [NSColor blackColor];
        
        titleLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
        titleLabel.fontSize = FONT_SIZE;
        titleLabel.fontColor = FONT_COLOR;
        
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
        scoreLabel.fontSize = FONT_SIZE;
        scoreLabel.fontColor = FONT_COLOR;
        
        lineThreeLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
        lineThreeLabel.fontSize = FONT_SIZE;
        lineThreeLabel.fontColor = FONT_COLOR;
        
        firstUpdate = YES;
    }
    
    return self;
}

- (id)initWithSize:(CGSize)size level:(int)aLevel score:(int)aScore time:(NSTimeInterval)time won:(BOOL)won {
    if (self = [self initWithSize:size]) {
        win = won;
        score = aScore;
        level = aLevel;
        
        // Configure the labels depending on if this is a win (yay) or not...
        if (won) {
            lineFourLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
            lineFourLabel.fontSize = FONT_SIZE;
            lineFourLabel.fontColor = FONT_COLOR;
            
            int bonus = (int) time;
            int totalScore = score + bonus;
            
            titleLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Completed Level %.2d", level]];
            lineThreeLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Time Bonus %d", bonus]];
            lineFourLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Total %d", totalScore]];
        } else {
            titleLabel.text = [NSString stringByPaddingString:@"Game Over!"];
            lineThreeLabel.text = [NSString stringByPaddingString:@"Press Enter"];
        }
        
        scoreLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Score %d", score]];
        
        // Add the labels
        [self addChild:titleLabel];
        [self addChild:scoreLabel];
        [self addChild:lineThreeLabel];
        
        if (won) {
            [self addChild:lineFourLabel];
        }
        
        // Configure their positions
        if (won) {
            scoreLabel.position = CGPointMake(size.width / 2, size.height / 2 + PADDING);
            scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
            scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;

            lineThreeLabel.position = CGPointMake(size.width / 2, size.height / 2 - PADDING);
            lineThreeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
            lineThreeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            
            titleLabel.position = CGPointMake(size.width / 2, scoreLabel.position.y + FONT_SIZE + PADDING);
            titleLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
            titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            
            lineFourLabel.position = CGPointMake(size.width / 2, lineThreeLabel.position.y - FONT_SIZE - PADDING);
            lineFourLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
            lineFourLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        } else {
            scoreLabel.position = CGPointMake(size.width / 2, size.height / 2);
            scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
            scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            
            titleLabel.position = CGPointMake(size.width / 2, scoreLabel.position.y + FONT_SIZE / 2 + PADDING);
            titleLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBottom;
            titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            
            lineThreeLabel.position = CGPointMake(size.width / 2, scoreLabel.position.y - FONT_SIZE / 2 - PADDING);
            lineThreeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
            lineThreeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        }
    }
    
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    if (!firstUpdate) {
        NSTimeInterval timeElapsed = currentTime - startTime;
        
        if (timeElapsed >= TIME_SHOWN) {
            [delegate nextLevel:level + 1 startingScore:score];
        }
    } else {
        startTime = currentTime;
        
        firstUpdate = NO;
    }
}

- (void)keyDown:(NSEvent *)theEvent {
    if (theEvent.isARepeat) {
        return;
    }
    
    if (win == NO) {
        // Go to the main menu
        [delegate mainMenu];
    }
}

@end
