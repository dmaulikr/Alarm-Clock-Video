//
//  VideoPlayerController.m
//  AlarmClock
//
//  Created by roctian on 16/6/20.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import "VideoPlayerController.h"
#import "TPFTimerView.h"
#import "TPFInfoShareManager.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

//#define  timerViewHeight 44;
//#define  timerViewWidth 100;

@interface VideoPlayerController()

@property(strong,nonatomic)UIButton *closeButton;
@property(strong,nonatomic)MPMoviePlayerViewController *moviePlayerViewController;
@property(strong,nonatomic)MPMoviePlayerController *player;
@property(strong,nonatomic)UIView *overlay;

@property(strong,nonatomic)TPFTimerView *bottomTimerView;
@property(strong,nonatomic)TPFTimerView *topTimerView;

@property(strong,nonatomic)TPFTimerView *rightTimerView;
@property(strong,nonatomic)TPFTimerView *leftTimerView;

@property(strong,nonatomic)TPFTimerView *normalRightTimerView;

@property(nonatomic)float timerViewHeight;
@property(nonatomic)float timerViewWidth;

@end

@implementation VideoPlayerController

-(id)initWithMode:(VideoSelectMode)videoSelectMode{

    _videoSelectMode = videoSelectMode;
    
    return [self init];

}

-(id)init{

    self = [super init];
    if(self){
    
    
        [self initView];
    }

    return self;
}
-(void)viewWillAppear:(BOOL)animated{

    _closeButton.alpha = 0;
    [_player play];

}
-(void)viewWillDisappear:(BOOL)animated{

    [_player stop];

}

-(void)initView{
    
    _timerViewWidth = 80;
    _timerViewHeight = 30;
    
//    NSBundle *myBundle = [NSBundle mainBundle];
//    NSString* path = [myBundle pathForResource:@"IMG_0002" ofType:@"mov"];
    
//    字母LOGO-合成360_01.mov
    
//    NSBundle *myBundle = [NSBundle mainBundle];
//    NSString* path = [myBundle pathForResource:@"字母LOGO" ofType:@"mov"];
    
    AppDelegate * myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myAppDelegate.player play];
    
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString* path;
    
    if(_videoSelectMode == VideoSelectModeOne){
    
        path = [myBundle pathForResource:@"图形LOGO_UP" ofType:@"mov"];
        
        [self.view addSubview:self.bottomTimerView];
        [self.view addSubview:self.topTimerView];
        [self.view addSubview:self.rightTimerView];
        [self.view addSubview:self.leftTimerView];
    }
        
    else{
    
        path = [myBundle pathForResource:@"图形LOGO正面-MOV_01" ofType:@"mov"];
        [self.view addSubview:self.normalRightTimerView];
    }
    
    self.moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:path]];
    
    if(_videoSelectMode == VideoSelectModeOne){
        
        self.moviePlayerViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width);
        self.moviePlayerViewController.view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
        
    }
    
    else{
        
        self.moviePlayerViewController.view.frame = CGRectMake(0, 0, self.view.bounds.size.width-20, self.view.bounds.size.width-20);
        self.moviePlayerViewController.view.center = CGPointMake(self.view.bounds.size.width/2-25, self.view.bounds.size.height/2);
    }
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
    [self.moviePlayerViewController.view setTransform:transform];
    
    [self.view insertSubview:self.moviePlayerViewController.view belowSubview:_bottomTimerView?_bottomTimerView:_normalRightTimerView];
    
    
    // play movie
    _player = [self.moviePlayerViewController moviePlayer];
    _player.controlStyle = MPMovieControlStyleNone;
    _player.shouldAutoplay = YES;
    _player.repeatMode = MPMovieRepeatModeOne;
    [_player setFullscreen:YES animated:YES];
    _player.scalingMode = MPMovieScalingModeAspectFit;

    
   
    [self.view addSubview:self.overlay];
    
    self.closeButton.alpha = 0;
    
    [self.overlay addSubview:self.closeButton];
    
   
}

#pragma private method

-(void)tap:(UITapGestureRecognizer *)gesture{
    

    [UIView animateWithDuration:0.5f animations:^(){
    
        self.closeButton.alpha = self.closeButton.alpha==0?1:0;
    
    
    } completion:^(BOOL finished) {
        
    }];

}

-(void)closeAction:(UIButton *)sender{

    TPFInfoShareManager *shareManager = [TPFInfoShareManager shareManager];
    
    if(!shareManager.fromCloseApp)
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    else
        [self goToHome];

    
    
    [[self.moviePlayerViewController moviePlayer] stop];
    [_bottomTimerView stop];
    [_topTimerView stop];
    
    shareManager.fromCloseApp = false;
    
    AppDelegate * myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myAppDelegate.player stop];
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setValue:@"0" forKey:@"alarmOn"];
}
-(void)goToHome{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    HomeViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeView"];
    rootViewController.alarmGoingOff = NO;

    [self presentViewController:rootViewController animated:YES completion:^{
        
    }];
}

#pragma setter

-(void)setPath:(NSString *)path{

    _path = path;

    
}

#pragma getter

-(TPFTimerView *)bottomTimerView{

    if(!_bottomTimerView){

        float sub = (self.view.frame.size.height - self.view.frame.size.width)/2;
        float y = self.view.frame.size.height-sub- _timerViewHeight;
        
    _bottomTimerView = [[TPFTimerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-_timerViewWidth)/2,y, 100, _timerViewHeight) imageType:ImageTypeA timerPosition:TimerPositionBottom];
    
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
        [_bottomTimerView setTransform:transform];
    
    }

    return _bottomTimerView;

}

-(TPFTimerView *)topTimerView{
    
    if(!_topTimerView){
        
         float sub = (self.view.frame.size.height - self.view.frame.size.width)/2;
        
        _topTimerView = [[TPFTimerView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-_timerViewWidth)/2,sub, _timerViewWidth,_timerViewHeight) imageType:ImageTypeC timerPosition:TimerPositionTop];
        
        
//        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI);
//        [_topTimerView setTransform:transform];
    }
    
    return _topTimerView;
    
}
-(TPFTimerView *)rightTimerView{
    
    if(!_rightTimerView){
        
        
        _rightTimerView = [[TPFTimerView alloc] initWithFrame:CGRectMake(0,0,_timerViewWidth, _timerViewHeight) imageType:ImageTypeA timerPosition:TimerPositionRight];
        
//        CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI/2);
//        [self.rightTimerView setTransform:transform];
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
        [self.rightTimerView setTransform:transform];

        
        _rightTimerView.center = CGPointMake(self.view.frame.size.width - _timerViewHeight/2,self.view.frame.size.height/2);
    }
    
    return _rightTimerView;
    
}

-(TPFTimerView *)leftTimerView{
    
    if(!_leftTimerView){
        
        
        _leftTimerView = [[TPFTimerView alloc] initWithFrame:CGRectMake(0,0,_timerViewWidth,_timerViewHeight) imageType:ImageTypeC timerPosition:TimerPositionLeft];
        
//        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
//        [_leftTimerView setTransform:transform];
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI/2);
        [_leftTimerView setTransform:transform];
        
        _leftTimerView.center = CGPointMake(_timerViewHeight/2,self.view.frame.size.height/2);
        
    }
    
    return _leftTimerView;
    
}
-(TPFTimerView *)normalRightTimerView{

    if(!_normalRightTimerView){
        
        
        _normalRightTimerView = [[TPFTimerView alloc] initWithFrame:CGRectMake(0,0,_timerViewWidth, _timerViewHeight) imageType:ImageTypeA timerPosition:TimerPositionNormal];
        
        //        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
        //        [_leftTimerView setTransform:transform];
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI/2);
        [_normalRightTimerView setTransform:transform];
        
         _normalRightTimerView.center = CGPointMake(self.view.frame.size.width - _timerViewHeight/2,self.view.frame.size.height/2);
        
    }
    
    return _normalRightTimerView;


}

-(UIButton *)closeButton{
    
    if(!_closeButton){
        
        _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [_closeButton setTitle:@"退出" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.1]];
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



- (BOOL)prefersStatusBarHidden {
    return YES;
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

- (BOOL)shouldAutorotate
{
    return YES;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    
    return UIInterfaceOrientationMaskPortrait;
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return toInterfaceOrientation == UIDeviceOrientationPortrait;
}

@end
