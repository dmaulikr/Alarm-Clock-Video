//
//  ViewController.h
//  AlarmClock
//


#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIAlertViewDelegate>

@property(nonatomic) BOOL alarmGoingOff;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

- (IBAction)playVideoAction:(id)sender;
@end
