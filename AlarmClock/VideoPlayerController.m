//
//  VideoPlayerController.m
//  AlarmClock
//
//  Created by roctian on 16/6/20.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import "VideoPlayerController.h"

@interface VideoPlayerController()

@property(strong,nonatomic)UIButton *closeButton;
@property(strong,nonatomic)MPMoviePlayerViewController *videoView;

@end

@implementation VideoPlayerController

-(id)initWithContentURL:(NSURL *)contentURL{

    self = [super initWithContentURL:contentURL];
    if(self){
    
    
        [self initView];
    }

    return self;
}
-(void)initView{
    
    UIView *aView = [[UIView alloc] initWithFrame:self.view.bounds];
    [aView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    [self.view addSubview:aView];
    
    self.closeButton.alpha = 0;
    
    [self.view addSubview:self.closeButton];
    
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    self.view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
    [self.view setTransform:transform];
    
    transform = CGAffineTransformMakeRotation(-M_PI/2);
    [self.closeButton setTransform:transform];
    self.closeButton.center = CGPointMake(self.view.bounds.size.width/2, self.closeButton.frame.size.height/2);
    
    // play movie
    MPMoviePlayerController *player = [self moviePlayer];
    player.controlStyle = MPMovieControlStyleNone;
    player.shouldAutoplay = YES;
    player.repeatMode = MPMovieRepeatModeOne;
    [player setFullscreen:YES animated:YES];
    player.scalingMode = MPMovieScalingModeAspectFit;
    [player play];
    

}
-(void)tap:(UITapGestureRecognizer *)gesture{

    [UIView animateWithDuration:0.5f animations:^(){
    
        self.closeButton.alpha = self.closeButton.alpha==0?1:0;
    
    
    } completion:^(BOOL finished) {
        
    }];

}
-(UIButton *)closeButton{

    if(!_closeButton){
    
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [_closeButton setTitle:@"退出" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
    }
   
    return _closeButton;

}
-(void)closeAction:(UIButton *)sender{

    [self dismissViewControllerAnimated:YES completion:^{
        
        [[self moviePlayer] stop];
    }];

}
-(void)setPath:(NSString *)path{

    _path = path;

}

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    
//    return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
//    
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    return toInterfaceOrientation != UIDeviceOrientationPortraitUpsideDown;
//}
@end
