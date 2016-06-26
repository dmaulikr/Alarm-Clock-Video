//
//  VideoPlayerController.h
//  AlarmClock
//
//  Created by roctian on 16/6/20.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

typedef enum : NSUInteger {
    VideoSelectModeOne,
    VideoSelectModeTwo
} VideoSelectMode;

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VideoPlayerController : UIViewController

-(id)initWithMode:(VideoSelectMode)videoSelectMode;

@property(nonatomic)VideoSelectMode videoSelectMode;

@property(strong,nonatomic)NSString *path;

@end
