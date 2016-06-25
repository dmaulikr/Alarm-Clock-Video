//
//  TPFInfoShareManager.h
//  AlarmClock
//
//  Created by roctian on 16/6/22.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface TPFInfoShareManager : NSObject

+(instancetype)shareManager;

@property(nonatomic) BOOL fromCloseApp;

@property(nonatomic,strong)CMMotionManager *motionManager;

@property(nonatomic,strong)UIView *maskBlack;

@property(nonatomic)float accelerationX;

@property(nonatomic)float accelerationY;

@property(nonatomic)BOOL alarmOn;

@property(nonatomic)BOOL isLight;

@property(nonatomic)BOOL afterFiveSeconds;

@property(nonatomic)BOOL isRemove;

@property(nonatomic)CGFloat currentLight;

@end
