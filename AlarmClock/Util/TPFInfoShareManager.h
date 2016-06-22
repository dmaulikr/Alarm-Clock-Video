//
//  TPFInfoShareManager.h
//  AlarmClock
//
//  Created by roctian on 16/6/22.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPFInfoShareManager : NSObject

+(instancetype)shareManager;

@property(nonatomic) BOOL fromCloseApp;

@end
