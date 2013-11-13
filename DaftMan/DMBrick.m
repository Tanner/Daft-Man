//
//  DMBrick.m
//  DaftMan
//
//  Created by Tanner Smith on 11/12/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMBrick.h"

#import "DMRupee.h"
#import "DMStar.h"
#import "DMHeart.h"

@implementation DMBrick

@synthesize prize;

- (id)init {
    // TODO: Brick.png is only 30x30
    if (self = [super initWithImageNamed:@"brick.png"]) {
        self.name = @"brick";
        
        [self setSize:CGSizeMake(32, 32)];
    }
    
    return self;
}

- (id)initWithPrize:(SKSpriteNode *)aPrize {
    if (self = [self init]) {
        prize = aPrize;
    }
    
    return self;
}

- (id)initWithRandomPrize {
    if (self = [self init]) {
        PrizeType prizeType = arc4random() % 3;
        
        switch (prizeType) {
            case RUPEE:
                prize = [[DMRupee alloc] init];
                break;
            case STAR:
                prize = [[DMStar alloc] init];
                break;
            case HEART:
                prize = [[DMHeart alloc] init];
                break;
        }
    }
    
    return self;
}

- (void)destroy {
    if (prize) {
        SKNode *parent = [self parent];
        SKNode *items = [[parent parent] childNodeWithName:@"//items"];

        prize.position = self.position;
        
        [items addChild:prize];
    }
    
    [self removeFromParent];
}

- (BOOL)isImpassable {
    return YES;
}

- (BOOL)isDestructible {
    return YES;
}

@end
