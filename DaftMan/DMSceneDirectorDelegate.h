//
//  DMSceneDirectorDelegate.h
//  DaftMan
//
//  Created by Tanner Smith on 12/10/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMSceneDirectorDelegate <NSObject>

- (void)mainMenu;
- (void)levelCompleteForlevel:(int)aLevel score:(int)score time:(NSTimeInterval)time health:(int)health won:(BOOL)won;
- (void)nextLevel:(int)level startingScore:(int)score;
- (void)nextLevel:(int)level startingScore:(int)score startingHealth:(int)health;

@end
