//
//  ViewController.m
//  AlarmClock
//


#import "HomeViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayerController.h"
#import "TPFTimerView.h"

@interface HomeViewController ()

@property(strong,nonatomic)TPFTimerView *timerView;

@end


@implementation HomeViewController
@synthesize alarmGoingOff;

- (void)viewDidLoad
{
    [super viewDidLoad];
 
   
    [self.view addSubview:self.timerView];
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

- (IBAction)playVideoAction:(id)sender {
    
    
    VideoPlayerController *videoPlayerController = [[VideoPlayerController alloc] init];
    videoPlayerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController:videoPlayerController animated:YES completion:^(){}];
}

#pragma getter

-(TPFTimerView *)timerView{

    if(!_timerView){
    
        int height = 65;
        int widht = self.view.frame.size.width - 200;
        
        _timerView = [[TPFTimerView alloc] initWithFrame:CGRectMake(100,CGRectGetMaxY(self.logoImageView.frame)+20, widht, height) imageType:ImageTypeC timerPosition:TimerPositionNormal];
    
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
@end
