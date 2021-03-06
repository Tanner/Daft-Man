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

@synthesize item;

- (id)init {
    if (self = [super initWithImageNamed:@"brick.png"]) {
        self.name = @"brick";
    }
    
    return self;
}

- (id)initWithItem:(DMItem *)anItem {
    if (self = [self init]) {
        item = anItem;
    }
    
    return self;
}

- (id)initWithRupee {
    if (self = [self initWithItem:[[DMRupee alloc] init]]) {
        
    }
    
    return self;
}

- (id)initWithRandomItem {
    if (self = [self init]) {
        ItemType itemType = arc4random() % 3;
        
        switch (itemType) {
            case STAR:
                item = [[DMStar alloc] init];
                break;
            case RUPEE:
            case HEART:
                item = [[DMHeart alloc] init];
                break;
        }
    }
    
    return self;
}

- (void)destroy {
    if (item) {
        SKNode *parent = [self parent];
        SKNode *items = [[parent parent] childNodeWithName:@"//items"];

        item.position = self.position;
        
        [items addChild:item];
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
