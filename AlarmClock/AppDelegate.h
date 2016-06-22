//
//  AppDelegate.h
//  AlarmClock
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "VideoPlayerController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) AVAudioPlayer *player;

@property(nonatomic,strong) VideoPlayerController *videoPlayerController;

@end
