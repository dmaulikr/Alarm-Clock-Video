//
//  VideoPlayerController.m
//  AlarmClock
//
//  Created by roctian on 16/6/20.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import "VideoPlayerController.h"
#import "TPFTimerView.h"

#define  timerViewHeight 44;
#define  timerViewWidth 100;

@interface VideoPlayerController()

@property(strong,nonatomic)UIButton *closeButton;
@property(strong,nonatomic)MPMoviePlayerViewController *moviePlayerViewController;
@property(strong,nonatomic)UIView *overlay;

@property(strong,nonatomic)TPFTimerView *bottomTimerView;
@property(strong,nonatomic)TPFTimerView *topTimerView;

@end

@implementation VideoPlayerController

-(id)init{

    self = [super init];
    if(self){
    
    
        [self initView];
    }

    return self;
}
-(void)initView{
    
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString* path = [myBundle pathForResource:@"IMG_0002" ofType:@"mov"];
    
    self.moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    
    self.moviePlayerViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width);
    self.moviePlayerViewController.view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
    [self.moviePlayerViewController.view setTransform:transform];
    
    [self.view addSubview:self.moviePlayerViewController.view];
    
    
    // play movie
    MPMoviePlayerController *player = [self.moviePlayerViewController moviePlayer];
    player.controlStyle = MPMovieControlStyleNone;
    player.shouldAutoplay = YES;
    player.repeatMode = MPMovieRepeatModeOne;
    [player setFullscreen:YES animated:YES];
    player.scalingMode = MPMovieScalingModeAspectFit;
    [player play];

    
    [self.view addSubview:self.bottomTimerView];
    [self.view addSubview:self.topTimerView];
    
   
    [self.view addSubview:self.overlay];
    
    self.closeButton.alpha = 0;
    
    [self.overlay addSubview:self.closeButton];
    
   
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
-(UIView *)overlay{

    if(!_overlay){
        
        _overlay = [[UIView alloc] initWithFrame:self.view.bounds];
        [_overlay addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        
    }
    
    return _overlay;
}
-(void)closeAction:(UIButton *)sender{

    [self dismissViewControllerAnimated:YES completion:^{
        
        [[self.moviePlayerViewController moviePlayer] stop];
        [_bottomTimerView stop];
        [_topTimerView stop];
    }];

}
-(void)setPath:(NSString *)path{

    _path = path;

    
}

#pragma getter

-(TPFTimerView *)bottomTimerView{

    if(!_bottomTimerView){

        
    _bottomTimerView = [[TPFTimerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2,self.view.frame.size.height-44, 100, 44) imageType:ImageTypeA];
    
    
    }

    return _bottomTimerView;

}

-(TPFTimerView *)topTimerView{
    
    if(!_topTimerView){
        
        
        _topTimerView = [[TPFTimerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100)/2,0, 100, 44) imageType:ImageTypeA];
        
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
        [_topTimerView setTransform:transform];
    }
    
    return _topTimerView;
    
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
