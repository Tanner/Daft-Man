//
//  DMMusicPlayer.h
//  DaftMan
//
//  Created by Tanner Smith on 12/16/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface DMMusicPlayer : NSObject

@property (nonatomic, assign) MusicPlayer musicPlayer;
@property (nonatomic, assign) MusicSequence musicSequence;
@property (nonatomic, assign) MusicTrack tempoTrack;

+ (id)sharedMusicPlayer;

- (void)playSequence:(NSURL *)url beatsPerMinute:(double)bpm;

@end
