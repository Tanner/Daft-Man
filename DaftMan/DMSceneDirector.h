//
//  DMSceneDirector.h
//  DaftMan
//
//  Created by Tanner Smith on 12/9/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

#import "DMSceneDirectorDelegate.h"

@interface DMSceneDirector : NSObject <DMSceneDirectorDelegate>

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) SKView *view;

- (id)initWithSize:(CGSize)size view:(SKView *)view;

@end
