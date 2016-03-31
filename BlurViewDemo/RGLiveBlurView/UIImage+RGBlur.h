//
//  UIImage+RGBlur.h
//  BlurViewDemo
//
//  Created by roger wu on 16/3/31.
//  Copyright © 2016年 roger.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RGBlur)

/**
 *  获得模糊视图
 *
 *  @param imageToBlur 被模糊的图片
 *  @param radius  范围0-1
 *
 *  @return 模糊后的图片
 */
+ (UIImage *)blurImage:(UIImage *)imageToBlur withRadius:(CGFloat)radius;

@end
