//
//  ViewController.m
//  AlarmClock
//


#import "HomeViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayerController.h"
#import "TPFTimerView.h"
#import "selectVideoMode.h"

@interface HomeViewController ()

@property(strong,nonatomic)TPFTimerView *timerView;

@end


@implementation HomeViewController
@synthesize alarmGoingOff;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _bottomView.frame = CGRectMake(0, self.view.frame.size.height, _bottomView.frame.size.width, _bottomView.frame.size.height);
   
    [self.view insertSubview:self.timerView belowSubview:_bottomView];
}

- (void)viewWillAppear:(BOOL)animated
{

}

-(void)viewDidAppear:(BOOL)animated
{
    //This checks if the home view is shown because of an alarm firing
    if(self.alarmGoingOff)
    {
        UIAlertView *alarmAlert = [[UIAlertView alloc] initWithTitle:@"Alarm Going Off"
                                                             message:@"Press okay to stop"
                                                            delegate:self
                                                   cancelButtonTitle:@"okay"
                                                   otherButtonTitles:nil, nil];
        [alarmAlert show];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        AppDelegate * myAppDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [myAppDelegate.player stop];
    }
    else{
        //do nothing
    }
}

-(void)initSelectButton{

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *value  = [userDefaults valueForKey:@"selectVideoMode"];
    
    if(!value || [value isEqualToString:@"1"])
        
        [self selectOne];
    
    else
        [self selectTwo];


}

- (IBAction)playVideoAction:(id)sender {
    
    [self initSelectButton];
    
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0;
    backView.tag = 105;
    [backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeBottomView:)]];
    
    [self.view insertSubview:backView belowSubview:_bottomView];
    
    [UIView animateWithDuration:0.5f delay:0 usingSpringWithDamping:2 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut  animations:^{
        
        backView.alpha = 0.4;
        
        _bottomView.frame = CGRectMake(0, self.view.frame.size.height-_bottomView.frame.size.height, _bottomView.frame.size.width, _bottomView.frame.size.height);
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
}
-(void)closeBottomView:(UITapGestureRecognizer *)Recognizer{

    [self closeBottomViewMethod];
}
-(void)closeBottomViewMethod{

    UIView *backView = [self.view viewWithTag:105];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        backView.alpha = 0;
        _bottomView.frame = CGRectMake(0, self.view.frame.size.height, _bottomView.frame.size.width, _bottomView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [backView removeFromSuperview];
    }];


}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if([segue.identifier isEqualToString:@"goToSelect"]){
     
         selectVideoMode *videoMode = [segue destinationViewController];
        videoMode.modalPresentationStyle = UIModalPresentationOverCurrentContext;
     }
     
 }



#pragma getter

-(TPFTimerView *)timerView{

    if(!_timerView){
    
        int height = 65;
        int widht = self.view.frame.size.width - 200;
        
        _timerView = [[TPFTimerView alloc] initWithFrame:CGRectMake(100,CGRectGetMaxY(self.logoImageView.frame)+20, widht, height) imageType:ImageTypeA timerPosition:TimerPositionNormal];
    
    }

    return _timerView;
}

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
- (IBAction)oneModeAction:(id)sender {
    
    [self selectOne];
    
    VideoPlayerController *videoPlayerController = [[VideoPlayerController alloc] initWithMode:VideoSelectModeOne];
    videoPlayerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentViewController:videoPlayerController animated:YES completion:^(){
    
        [self closeBottomViewMethod];
    
    }];
}

- (IBAction)twoModeAction:(id)sender {
    
    [self selectTwo];
    
    VideoPlayerController *videoPlayerController = [[VideoPlayerController alloc] initWithMode:VideoSelectModeTwo];
    videoPlayerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [self presentViewController:videoPlayerController animated:YES completion:^(){
    
         [self closeBottomViewMethod];
    
    }];
}

- (IBAction)cancelAction:(id)sender {
    
     [self closeBottomViewMethod];
}
-(void)selectOne{

    [_oneSlectButton setImage:[UIImage imageNamed:@"预约结算3.png"] forState:UIControlStateNormal];
    [_twoSelectButton setImage:[UIImage imageNamed:@"预约结算4.png"] forState:UIControlStateNormal];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@"1" forKey:@"selectVideoMode"];

}
-(void)selectTwo{
    
    [_oneSlectButton setImage:[UIImage imageNamed:@"预约结算4.png"] forState:UIControlStateNormal];
    [_twoSelectButton setImage:[UIImage imageNamed:@"预约结算3.png"] forState:UIControlStateNormal];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@"2" forKey:@"selectVideoMode"];
    
}
@end
