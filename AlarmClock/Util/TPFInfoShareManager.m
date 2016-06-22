//
//  TPFInfoShareManager.m
//  AlarmClock
//
//  Created by roctian on 16/6/22.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import "TPFInfoShareManager.h"

@implementation TPFInfoShareManager

+(instancetype)shareManager{
    static dispatch_once_t once;
    static id instance;
    dispatch_once(&once, ^{
        instance = [self new];
    });
    return instance;
}

@end
