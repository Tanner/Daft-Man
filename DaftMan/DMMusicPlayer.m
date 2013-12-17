//
//  DMMusicPlayer.m
//  DaftMan
//
//  Created by Tanner Smith on 12/16/13.
//  Copyright (c) 2013 Tanner Smith. All rights reserved.
//

#import "DMMusicPlayer.h"

@implementation DMMusicPlayer

@synthesize musicPlayer;
@synthesize musicSequence, tempoTrack;

+ (id)sharedMusicPlayer {
    static dispatch_once_t onceToken;
    static DMMusicPlayer *player;
    
    dispatch_once(&onceToken, ^{
        player = [[DMMusicPlayer alloc] init];
    });
    
    return player;
}

- (id)init {
    if (self = [super init]) {
        NewMusicPlayer(&musicPlayer);
    }
    
    return self;
}

- (void)playSequence:(NSURL *)url beatsPerMinute:(double)bpm {
    if (musicSequence) {
        [self stop];
        
        DisposeMusicSequence(musicSequence);
    }
    
    if (NewMusicSequence(&musicSequence) != 0) {
        [NSException raise:@"play" format:@"Can't create MusicSequence"];
    }

    if (MusicSequenceFileLoad(musicSequence, (__bridge CFURLRef) url, 0, 0) != 0) {
        [NSException raise:@"play" format:@"Can't load MusicSequence"];
    }

    if (MusicSequenceGetTempoTrack(musicSequence, &tempoTrack) != noErr) {
        [NSException raise:@"main" format:@"Cannot get tempo track."];
    }

    if (MusicTrackNewExtendedTempoEvent(tempoTrack, 0.0, 120) != noErr) {
        [NSException raise:@"main" format:@"Cannot add tempo event."];
    }

    MusicPlayerSetSequence(musicPlayer, musicSequence);
    MusicPlayerPreroll(musicPlayer);
    
    [self start];
}

- (void)start {
    if (musicPlayer) {
        MusicPlayerStart(musicPlayer);
    }
}

- (void)stop {
    if (musicPlayer) {
        MusicPlayerStop(musicPlayer);
    }
}

- (void)dealloc {
    [self stop];
    
    if (musicSequence) {
        DisposeMusicSequence(musicSequence);
    }
    
    DisposeMusicPlayer(musicPlayer);
}

@end
