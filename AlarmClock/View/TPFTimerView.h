//
//  TPFTimerView.h
//  AlarmClock
//
//  Created by tianpengfei on 16/6/21.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ImageTypeA,
    ImageTypeB,
    ImageTypeC,
} ImageType;


typedef enum : NSUInteger {
    TimerPositionBottom,
    TimerPositionTop,
    TimerPositionLeft,
    TimerPositionRight,
    TimerPositionNormal
} TimerPosition;

@interface TPFTimerView : UIView

-(id)initWithFrame:(CGRect)frame imageType:(ImageType)type timerPosition:(TimerPosition)timerPosition;

@property(nonatomic)ImageType type;
@property(nonatomic)TimerPosition timerPosition;

-(void)stop;
@end
