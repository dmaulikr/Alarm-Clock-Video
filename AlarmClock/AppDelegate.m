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
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
        
        [[UIApplication sharedApplication]  registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        
    }
    
    //Prevents screen from locking
    [UIApplication sharedApplication].idleTimerDisabled = YES;    
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    TPFInfoShareManager *shareManager = [TPFInfoShareManager shareManager];
    
    if (localNotif)
    {
        [self setupWindow];
        shareManager.fromCloseApp = YES;
    }
    else
        shareManager.fromCloseApp = NO;
        
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Best_Morning_Alarm" ofType:@"m4r"];
//    
//    NSURL *file = [[NSURL alloc] initFileURLWithPath:path];   
//    
//    self.player =[[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
//    [self.player prepareToPlay];
//    [self.player play];
    
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

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
