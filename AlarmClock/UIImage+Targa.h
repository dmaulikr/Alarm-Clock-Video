//
//  UIImage+Targa.h
//  AlarmClock
//
//  Created by roctian on 16/6/21.
//  Copyright © 2016年 Jon Bauer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Targa)

+(id)imageFromTGAFile:(NSString *)filename;
+(id)imageFromTGAData:(NSData *)data;
+(id)imageWithRawRGBAData:(NSData *)data width:(int)width height:(int)height;

@end
