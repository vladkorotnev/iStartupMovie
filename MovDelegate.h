#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#include <MediaPlayer/MediaPlayer.h>
@interface MovDelegate : NSObject  {

}

- (void)myMovieFinishedCallback:(NSNotification*)aNotification;

@end