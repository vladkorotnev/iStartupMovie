#include <MediaPlayer/MediaPlayer.h>
#include "MovDelegate.h"
#include <UIKit/UIKit.h>
%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)x {
    %orig;
    NSFileManager *fm=[NSFileManager defaultManager];
    MovDelegate *ololo = [MovDelegate alloc];
    if([fm fileExistsAtPath:@"/var/mobile/startup.mov"]){
    MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:@"/var/mobile/startup.mov"]];
    player.view.frame = [[UIScreen mainScreen]bounds];
    if ([player respondsToSelector:@selector(setControlStyle:)]) {
        player.controlStyle = MPMovieControlStyleNone;
    } 
    player.scalingMode = MPMovieScalingModeAspectFill;
    [[NSNotificationCenter defaultCenter]addObserver:ololo selector:@selector(myMovieFinishedCallback:) name:@"MPMoviePlayerPlaybackDidFinishNotification" object:player];
    player.view.userInteractionEnabled = NO;
    Class _SBAwayController = NSClassFromString(@"SBAwayController");
    [[[_SBAwayController sharedAwayController]awayView] setFullscreen:true duration:1 force:true];
    [[[_SBAwayController sharedAwayController]awayView] addSubview:player.view];
    
    [player play];
    NSLog(@"Movie playing now");
    
    }
    [fm release];
}
    
%end