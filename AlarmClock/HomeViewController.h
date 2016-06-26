//
//  ViewController.h
//  AlarmClock
//


#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIAlertViewDelegate>

@property(nonatomic) BOOL alarmGoingOff;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

- (IBAction)playVideoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)oneModeAction:(id)sender;
- (IBAction)twoModeAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *oneSlectButton;
@property (weak, nonatomic) IBOutlet UIButton *twoSelectButton;
@end
