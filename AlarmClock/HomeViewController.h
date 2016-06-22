//
//  ViewController.h
//  AlarmClock
//


#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIAlertViewDelegate>

@property(nonatomic) BOOL alarmGoingOff;

- (IBAction)playVideoAction:(id)sender;
@end
