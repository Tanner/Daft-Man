//
//  DMScoreBoard.m
//  DaftMan
//
//  Created by Tanner Smith on 12/8/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMScoreBoard.h"

@implementation DMScoreBoard

#define PADDING 16
#define WIDTH (16 * 32)

#define FONT @"Courier"
#define FONT_SIZE 26
#define FONT_COLOR [NSColor whiteColor];

@synthesize scoreLabel, levelLabel, timeLabel, rupeesLabel;
@synthesize hearts;

- (id)init {
    if (self = [super init]) {
        scoreLabel = [[SKLabelNode alloc] initWithFontNamed:FONT];
        levelLabel = [[SKLabelNode alloc] initWithFontNamed:FONT];
        timeLabel = [[SKLabelNode alloc] initWithFontNamed:FONT];
        rupeesLabel = [[SKLabelNode alloc] initWithFontNamed:FONT];
        
        scoreLabel.position = CGPointMake(PADDING, SCOREBOARD_HEIGHT - PADDING);
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        scoreLabel.fontSize = FONT_SIZE;
        scoreLabel.fontColor = FONT_COLOR;

        levelLabel.position = CGPointMake(WIDTH / 2, SCOREBOARD_HEIGHT - PADDING);
        levelLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        levelLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        levelLabel.fontSize = FONT_SIZE;
        levelLabel.fontColor = FONT_COLOR;
        
        timeLabel.position = CGPointMake(WIDTH - PADDING, SCOREBOARD_HEIGHT - PADDING);
        timeLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        timeLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeTop;
        timeLabel.fontSize = FONT_SIZE;
        timeLabel.fontColor = FONT_COLOR;
        
        rupeesLabel.position = CGPointMake(WIDTH - PADDING, PADDING);
        rupeesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        rupeesLabel.verticalAlignmentMode = SKLabelVerticalAlignmentModeBaseline;
        rupeesLabel.fontSize = FONT_SIZE;
        rupeesLabel.fontColor = FONT_COLOR;
        
        [self setScore:0];
        [self setLevel:0];
        [self setTime:0];
        [self setRupees:0];
        
        [self addChild:scoreLabel];
        [self addChild:levelLabel];
        [self addChild:timeLabel];
        [self addChild:rupeesLabel];
    }
    
    return self;
}

- (void)setScore:(int)score {
    scoreLabel.text = [NSString stringWithFormat:@"Score %d", score];
}

- (void)setLevel:(int)level {
    levelLabel.text = [NSString stringWithFormat:@"Level %d", level];
}

- (void)setTime:(NSTimeInterval)time {
    timeLabel.text = [NSString stringWithFormat:@"Time %d", (int) time];
}

- (void)setRupees:(int)rupees {
    rupeesLabel.text = [NSString stringWithFormat:@"Rupees %d", rupees];
}

@end
