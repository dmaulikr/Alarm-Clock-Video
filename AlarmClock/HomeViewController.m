//
//  ViewController.m
//  AlarmClock
//


#import "HomeViewController.h"
#import "AppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoPlayerController.h"
#import "UIImage+Targa.h"

@interface HomeViewController ()

@end


@implementation HomeViewController
@synthesize hour1Label;
@synthesize hour2Label;
@synthesize minute1Label;
@synthesize minute2Label;
@synthesize colon1;
@synthesize alarmGoingOff;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self myTimerAction];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //How often to update the clock labels
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(myTimerAction) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:timer forMode:UITrackingRunLoopMode];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [self saveTgaImage];
}

- (void)viewWillAppear:(BOOL)animated
{
    //This is what sets the custom font
    //See -http://stackoverflow.com/questions/360751/can-i-embed-a-custom-font-in-an-iphone-application
    colon1.font = [UIFont fontWithName:@"digital-7" size:90];
    hour1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    minute1Label.font = [UIFont fontWithName:@"digital-7" size:90];
    hour2Label.font = [UIFont fontWithName:@"digital-7" size:90];
    minute2Label.font = [UIFont fontWithName:@"digital-7" size:90];

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

//This updates the clock labels
-(void)myTimerAction
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *hourMinuteSecond = [dateFormatter stringFromDate:date];

    hour1Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(0, 1)];
    hour2Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(1, 1)];
    minute1Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(3, 1)];
    minute2Label.text = [hourMinuteSecond substringWithRange:NSMakeRange(4, 1)];
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
-(void)saveTgaImage{

    for (int i =0; i<=10; i++) {
        
        NSString *AName = [NSString stringWithFormat:@"%d-A.tga",i];
        NSString *BName = [NSString stringWithFormat:@"%d-B.tga",i];
        NSString *CName = [NSString stringWithFormat:@"%d-C.tga",i];
        
        NSString *APath = [[NSBundle mainBundle] pathForResource:AName ofType:@""];
        
        UIImage *AImage = [UIImage imageFromTGAFile:APath];
//        UIImage *BImage = [UIImage imageFromTGAFile:BName];
//        UIImage *CImage = [UIImage imageFromTGAFile:CName];
        
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"/手机闹钟数字/"];
        
        NSString *filePath = [myDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d-A.png",i]];
        
        
        [UIImagePNGRepresentation(AImage) writeToFile:filePath atomically:YES];
        
        filePath = [myDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d-B.png",i]];
        
        
//        [UIImagePNGRepresentation(BImage) writeToFile:filePath atomically:YES];
//        
//        filePath = [myDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%d-C.png",i]];
//        
//        NSLog(@"documentsDirectory%@",filePath);
//        
//        [UIImagePNGRepresentation(CImage) writeToFile:filePath atomically:YES];
        
    }
}
@end
