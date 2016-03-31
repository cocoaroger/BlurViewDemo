//
//  RGLiveBlurView.h
//  BlurViewDemo
//
//  Created by roger wu on 16/3/31.
//  Copyright © 2016年 roger.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGLiveBlurView : UIImageView

/**
 *  原图
 */
@property (nonatomic, strong) UIImage *originalImage;
/**
 *  图片跟随该滚动图的滚动值做模糊改变
 */
@property (nonatomic, weak)   UIScrollView *scrollView;
/**
 *  初始模糊值
 */
@property (nonatomic, assign) CGFloat initialBlurLevel;
/**
 *  初始毛玻璃值
 */
@property (nonatomic, assign) CGFloat initialGlassLevel;
/**
 *  是否毛玻璃效果
 */
@property (nonatomic, assign) CGFloat isGlassEffectOn;
/**
 *  毛玻璃颜色
 */
@property (nonatomic, strong) UIColor *glassColor;

/**
 *  设置模糊值
 *
 *  @param blurLevel 0-1
 */
- (void)setBlurLevel:(CGFloat)blurLevel;
@end
