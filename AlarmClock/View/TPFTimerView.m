//
//  TPFTimerView.m
//  AlarmClock
//
//  Created by tianpengfei on 16/6/21.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import "TPFTimerView.h"

@interface TPFTimerView ()

@property(strong,nonatomic)UIImageView *hour1;
@property(strong,nonatomic)UIImageView *hour2;

@property(strong,nonatomic)UIImageView *minute1;
@property(strong,nonatomic)UIImageView *minute2;

@property(strong,nonatomic)UIImageView *point;

@property(nonatomic)float width;
@property(nonatomic)float pointWidth;
@property(nonatomic)float height;

@property(strong,nonatomic)NSTimer *timer;

@end

@implementation TPFTimerView

-(id)initWithFrame:(CGRect)frame imageType:(ImageType)type{

    self = [super initWithFrame:frame];

    if(self){
    
        _type = type;
        
        [self initView];
        
    }

    return self;
}
-(void)initView{
    
    _pointWidth  = self.frame.size.width/6;
    _width = (self.frame.size.width-_pointWidth)/4;
    _height = self.frame.size.height;

    [self addSubview:self.hour1];
    [self addSubview:self.hour2];
    [self addSubview:self.point];
    [self addSubview:self.minute1];
    [self addSubview:self.minute2];
    
    [self myTimerAction];
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    //How often to update the clock labels
    _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(myTimerAction) userInfo:nil repeats:YES];
    [runloop addTimer:_timer forMode:NSRunLoopCommonModes];
    [runloop addTimer:_timer forMode:UITrackingRunLoopMode];
    
    [self animatePoint];
}

#pragma private method

-(void)myTimerAction
{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"HH:mm a"];
    NSString *hourMinuteSecond = [dateFormatter stringFromDate:date];
    
    int h1 = [[hourMinuteSecond substringWithRange:NSMakeRange(0, 1)] intValue];
    int h2 = [[hourMinuteSecond substringWithRange:NSMakeRange(1, 1)] intValue];
    int m1 = [[hourMinuteSecond substringWithRange:NSMakeRange(3, 1)] intValue];
    int m2 = [[hourMinuteSecond substringWithRange:NSMakeRange(4, 1)] intValue];
    
    _hour1.image = [UIImage imageNamed:[self getImageName:h1]];
    _hour2.image = [UIImage imageNamed:[self getImageName:h2]];
    _minute1.image = [UIImage imageNamed:[self getImageName:m1]];
    _minute2.image = [UIImage imageNamed:[self getImageName:m2]];

}
-(void)animatePoint{


    [UIView animateWithDuration:0.5 animations:^{
        
        self.point.alpha =  self.point.alpha==1?0:1;
        
    } completion:^(BOOL finished) {
        
        [self animatePoint];
    }];


}

-(NSString *)getImageName:(int)index{

    return [NSString stringWithFormat:@"%d-%@.png",index,[self getTypeString]];

}
-(NSString *)getTypeString{

    NSString *typeString = @"A";
    
    switch (_type) {
        case ImageTypeA:
            typeString = @"A";
            break;
            
        case ImageTypeB:
            typeString = @"B";
            break;
            
        case ImageTypeC:
            typeString = @"C";
            break;
            
        default:
            break;
    }

    return typeString;

}

#pragma public API

-(void)stop{
    
    [_timer invalidate];
    _timer = nil;

}

#pragma setter

-(void)setType:(ImageType)type{


    _type = type;

     _point.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-%@.png",10,[self getTypeString]]];
    [self myTimerAction];
}

#pragma getter

-(UIImageView *)hour1{

    if(!_hour1){
    
        _hour1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
        _hour1.contentMode = UIViewContentModeScaleToFill;
    
    }

    return _hour1;
}
-(UIImageView *)hour2{
    
    if(!_hour2){
        
        _hour2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hour1.frame),0, _width, _height)];
        _hour2.contentMode = UIViewContentModeScaleToFill;
        
    }
    
    return _hour2;
}
-(UIImageView *)point{
    
    if(!_point){
        
        _point = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_hour2.frame),0, _pointWidth, _height)];
        _point.contentMode = UIViewContentModeScaleToFill;
        _point.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d-%@.png",10,[self getTypeString]]];
        
    }
    
    return _point;
}
-(UIImageView *)minute1{
    
    if(!_minute1){
        
        _minute1 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_point.frame), 0, _width, _height)];
        _minute1.contentMode = UIViewContentModeScaleToFill;
        
    }
    
    return _minute1;
}
-(UIImageView *)minute2{
    
    if(!_minute2){
        
        _minute2 = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_minute1.frame), 0, _width, _height)];
        _minute2.contentMode = UIViewContentModeScaleToFill;
        
    }
    
    return _minute2;
}
@end
