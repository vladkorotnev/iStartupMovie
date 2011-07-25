#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import "MovDelegate.h"
#import <UIKit/UIKit.h>
@implementation MovDelegate

-(void)myMovieFinishedCallback:(NSNotification*)aNotification 
{
 MPMoviePlayerController* theMovie=[aNotification object]; 
  Class _SBAwayController = NSClassFromString(@"SBAwayController");

        theMovie.view.hidden = true;
   // [[[_SBAwayController sharedAwayController]awayView] showAwayItems];
  //[[[_SBAwayController sharedAwayController]awayView] setShowingDeviceLock:TRUE duration:0.5f];
        [[[_SBAwayController sharedAwayController]awayView] setFullscreen:false duration:3 force:true];
    [[NSNotificationCenter defaultCenter] removeObserver:self 
                                                    name:MPMoviePlayerPlaybackDidFinishNotification 
                                                  object:theMovie]; 
	NSLog(@"Movie played");
    // Release the movie instance
    [theMovie release]; 

}

@end