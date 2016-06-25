//
//  AppDelegate.m
//  AlarmClock
//


#import "AppDelegate.h"
#import "HomeViewController.h"
#import "UIWindow+PazLabs.h"
#import "TPFInfoShareManager.h"

@implementation AppDelegate

@synthesize player;

- (void)setupWindow
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];    
    VideoPlayerController *videoPlayerController =  [[VideoPlayerController alloc] init];
    
	self.window.rootViewController = videoPlayerController;
	[self.window makeKeyAndVisible];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    
//    if(![userDefault valueForKey:@"alarmOn"])
//        [userDefault setValue:@"0" forKey:@"alarmOn"];
    
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        
        [[UIApplication sharedApplication]  registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
    }
    
    //Prevents screen from locking
    [UIApplication sharedApplication].idleTimerDisabled = YES;    
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    TPFInfoShareManager *shareManager = [TPFInfoShareManager shareManager];
    shareManager.isLight = true;
    shareManager.afterFiveSeconds = false;
    shareManager.isRemove = true;
    
    if (localNotif)
    {
        [self setupWindow];
        shareManager.fromCloseApp = YES;
    }
    else
        shareManager.fromCloseApp = NO;
    
    [self initCMMotionManager];
        
    return YES;
}

#pragma mark init method

-(void)initCMMotionManager{

    TPFInfoShareManager *shareManager = [TPFInfoShareManager shareManager];

    shareManager.maskBlack = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    shareManager.maskBlack.backgroundColor = [UIColor blackColor];
    [shareManager.maskBlack addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)]];
    
    _quene = [[NSOperationQueue alloc] init];
    
     shareManager.motionManager=[[CMMotionManager alloc]init];
    //判断加速计是否可用
    if ([shareManager.motionManager isAccelerometerAvailable]) {
        // 设置加速计频率
        [shareManager.motionManager setAccelerometerUpdateInterval:0.5];
        //开始采样数据
        [shareManager.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
            
            NSLog(@"%f---%f",accelerometerData.acceleration.x,accelerometerData.acceleration.y);
            
            shareManager.accelerationX = accelerometerData.acceleration.x;
            shareManager.accelerationY = accelerometerData.acceleration.y;
            
            if([self.window.visibleViewController isKindOfClass:[VideoPlayerController class]]){
            
                [self lightMaskView];
                return ;
            
            }
    
            
            BOOL x = fabs(accelerometerData.acceleration.x) < 0.05;
            BOOL y = fabs(accelerometerData.acceleration.y) < 0.05;
         
            
            if(x && y && shareManager.isLight){
            
                [self addMaskView];
                return;
            }
            
            if((!x || !y) && !shareManager.isLight){
                
                [self lightMaskView];
                
            }
                
            
            
        }];
    } else {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"不支持陀螺仪" preferredStyle:UIAlertControllerStyleAlert];
        
        [self.window.visibleViewController presentViewController:alertController animated:YES completion:nil];
    }
    
}

#pragma mark private method

-(void)addMaskView{

    TPFInfoShareManager *shareManager = [TPFInfoShareManager shareManager];

    if(shareManager.afterFiveSeconds)
        return;
    
    shareManager.afterFiveSeconds = true;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        if([self.window.visibleViewController isKindOfClass:[VideoPlayerController class]])
            return ;
            
        BOOL x = fabs(shareManager.accelerationX) < 0.05;
        BOOL y = fabs(shareManager.accelerationY) < 0.05;
        
        if(x && y){
        
            shareManager.maskBlack.alpha = 0;
            
            [self.window.visibleViewController.view addSubview:shareManager.maskBlack];
            
            [UIView animateWithDuration:0.5 animations:^{
                
                shareManager.maskBlack.alpha = 1;
                
            } completion:^(BOOL finished) {
                
                shareManager.isLight = false;
                 shareManager.afterFiveSeconds = false;
                shareManager.isRemove = false;
                shareManager.currentLight = [[UIScreen mainScreen] brightness];
                [[UIScreen mainScreen] setBrightness: 0.0];
                
            }];
        
        }
        else{
        
             shareManager.afterFiveSeconds = false;
        
        }
        
    });

}
-(void)lightMaskView{

    TPFInfoShareManager *shareManager = [TPFInfoShareManager shareManager];
    
    if(shareManager.isRemove)
        return;
    
    shareManager.isRemove = true;
    
    [[UIScreen mainScreen] setBrightness: 0.7];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        shareManager.maskBlack.alpha = 0;
        
    } completion:^(BOOL finished) {
    
        shareManager.isRemove = true;
        [ shareManager.maskBlack removeFromSuperview];
         shareManager.isLight = true;
        
        
    }];
}
-(void)tapHandler:(UITapGestureRecognizer *)recognizer{

    [self lightMaskView];

}

#pragma mark getter

-(AVAudioPlayer *)player{

    if(!player){
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Best_Morning_Alarm" ofType:@"m4r"];
        
        NSURL *file = [[NSURL alloc] initFileURLWithPath:path];
        
        self.player =[[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
        self.player.numberOfLoops = MAXFLOAT;

    }

    return player;
}

#pragma mark  didReceiveLocalNotification

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
//    [userDefault setValue:@"1" forKey:@"alarmOn"];
    
    [self lightMaskView];
    
   
    [self.player prepareToPlay];
    [self.player play];
    
    _videoPlayerController =  [[VideoPlayerController alloc] init];
    _videoPlayerController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    /*for testing when we stupidly are setting duplicate alarms*/
    if ([self.window visibleViewController] == _videoPlayerController)
        return;
    
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        //NSLog(@"didReceiveLocalNotification already in foreground, ring alarm");
        /*we were already up. play the alarm and bring up the alarm view (stop/snooze)*/
        
        [self.window.visibleViewController presentViewController:_videoPlayerController animated:YES completion:nil];
    }
    else
    {
        /*we were in the background. bring dialog and schedule a snooze wakeup*/
        //NSLog(@"didReceiveLocalNotification in background, alarm should have been ringing.");

        [self.window.visibleViewController presentViewController:_videoPlayerController animated:YES completion:nil];

    }
    
}

#pragma mark AppDelegate

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
     [[UIScreen mainScreen] setBrightness: 0.7];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     [[UIScreen mainScreen] setBrightness: 0.7];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
     [self lightMaskView];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
