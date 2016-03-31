//
//  RGLiveBlurView.m
//  BlurViewDemo
//
//  Created by roger wu on 16/3/31.
//  Copyright © 2016年 roger.wu. All rights reserved.
//

#import "RGLiveBlurView.h"
#import "UIImage+RGBlur.h"

static const CGFloat kBlurredBackgroundDefaultLevel = 0.9f;
static const CGFloat kBlurredBackgroundDefaultGlassLevel = 0.2f;

@interface RGLiveBlurView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) UIView *backgroundGlassView;

@end

@implementation RGLiveBlurView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _initialBlurLevel = kBlurredBackgroundDefaultLevel;
    _initialGlassLevel = kBlurredBackgroundDefaultGlassLevel;
    _glassColor = [UIColor whiteColor];
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _backgroundImageView.alpha = 0.0;
    _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
    _backgroundImageView.backgroundColor = [UIColor clearColor];
    _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:_backgroundImageView];
    
    _backgroundGlassView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundGlassView.alpha = 0.0;
    _backgroundGlassView.backgroundColor = _glassColor;
    _backgroundGlassView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview: _backgroundGlassView];
}

- (void)setGlassColor:(UIColor *)glassColor {
    _glassColor = glassColor;
    _backgroundGlassView.backgroundColor = glassColor;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    _scrollView = scrollView;
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)setOriginalImage:(UIImage *)originalImage {
    _originalImage = originalImage;
    self.image = originalImage;
    
    __weak __typeof(&*self) weakSelf = self;
    dispatch_queue_t queue = dispatch_queue_create("Blur queue", NULL);
    dispatch_async(queue, ^ {
        UIImage *blurredImage = [UIImage blurImage:originalImage withRadius:weakSelf.initialBlurLevel];
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.backgroundImageView.alpha = 0.0;
            weakSelf.backgroundImageView.image = blurredImage;
        });
    });
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    [self setBlurLevel:(self.scrollView.contentOffset.y + self.scrollView.contentInset.top) / (2 * CGRectGetHeight(self.bounds) / 3)];
}

- (void)setBlurLevel:(CGFloat)blurLevel {
    self.backgroundImageView.alpha = blurLevel;
    if (self.isGlassEffectOn) {
        self.backgroundGlassView.alpha = MAX(0.0, MIN(self.backgroundImageView.alpha - self.initialGlassLevel, self.initialGlassLevel));
    }

}

- (void)dealloc {
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
