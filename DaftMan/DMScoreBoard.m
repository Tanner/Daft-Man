//
//  DMScoreBoard.m
//  DaftMan
//
//  Created by Tanner Smith on 12/8/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMScoreBoard.h"

#import "NSString+DMFontPadding.h"

@implementation DMScoreBoard

#define PADDING 16
#define WIDTH (16 * 32)

#define HEART_PADDING 2

#define FONT @"ARCADECLASSIC"
#define FONT_SIZE 26
#define FONT_COLOR [NSColor whiteColor];

@synthesize scoreLabel, levelLabel, timeLabel, rupeesLabel;
@synthesize heartTexture, heartsNode;

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
        
        heartTexture = [SKTexture textureWithImageNamed:@"heart-small.png"];
        
        heartsNode = [[SKNode alloc] init];
        heartsNode.position = CGPointMake(PADDING, PADDING);
        
        [self setScore:0];
        [self setLevel:0];
        [self setTime:0];
        [self setRupees:0];
        
        [self addChild:scoreLabel];
        [self addChild:levelLabel];
        [self addChild:timeLabel];
        [self addChild:rupeesLabel];
        [self addChild:heartsNode];
    }
    
    return self;
}

- (void)setScore:(int)score {
    scoreLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Score %.2d", score]];
}

- (void)setLevel:(int)level {
    levelLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Level %.2d", level]];
}

- (void)setTime:(NSTimeInterval)time {
    timeLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Time %.3d", (int) time]];
}

- (void)setRupees:(int)rupees {
    rupeesLabel.text = [NSString stringByPaddingString:[NSString stringWithFormat:@"Rupees %.2d", rupees]];
}

- (void)setHearts:(int)hearts {
    [heartsNode removeAllChildren];

    if (hearts <= 0) {
        return;
    }
    
    for (int i = 0; i < hearts; i++) {
        SKSpriteNode *heart = [[SKSpriteNode alloc] initWithTexture:heartTexture];
        
        heart.position = CGPointMake(i * heartTexture.size.width + i * HEART_PADDING, 0);
        heart.anchorPoint = CGPointMake(0, 0);
        
        [heartsNode addChild:heart];
    }
}

@end
