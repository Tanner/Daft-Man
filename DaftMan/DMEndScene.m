//
//  DMEndScene.m
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMEndScene.h"

@implementation DMEndScene

#define FONT @"ARCADECLASSIC"
#define FONT_SIZE 26
#define FONT_COLOR [NSColor whiteColor]

#define PADDING 9

@synthesize titleLabel, scoreLabel;
@synthesize lineThreeLabel, lineFourLabel;

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
    }
    
    return self;
}

- (id)initWithSize:(CGSize)size level:(int)level score:(int)score time:(NSTimeInterval)time won:(BOOL)won {
    if (self = [self initWithSize:size]) {
        // Configure the labels depending on if this is a win (yay) or not...
        if (won) {
            lineFourLabel = [SKLabelNode labelNodeWithFontNamed:FONT];
            lineFourLabel.fontSize = FONT_SIZE;
            lineFourLabel.fontColor = FONT_COLOR;
            
            int bonus = (int) time;
            int totalScore = score + bonus;
            
            titleLabel.text = [NSString stringWithFormat:@"Completed Level %.2d", level];
            lineThreeLabel.text = [NSString stringWithFormat:@"Time Bonus %d", bonus];
            lineFourLabel.text = [NSString stringWithFormat:@"Total %d", totalScore];
        } else {
            titleLabel.text = @"Game Over!";
            lineThreeLabel.text = @"Press Enter";
        }
        
        scoreLabel.text = [NSString stringWithFormat:@"Score %d", score];
        
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

@end
