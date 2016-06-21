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

@interface TPFTimerView : UIView

-(id)initWithFrame:(CGRect)frame imageType:(ImageType)type;

@property(nonatomic)ImageType type;

-(void)stop;
@end
