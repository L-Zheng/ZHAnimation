//
//  ZHMarqueeView.m
//  ZHView
//
//  Created by 李保征 on 2018/2/26.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "ZHMarqueeView.h"

@interface ZHMarqueeView ()<CAAnimationDelegate>

@property (nonatomic,strong) UIView *animationView;

@end

@implementation ZHMarqueeView

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        
        [self configProperty];
        [self addSubview:self.animationView];
    }
    return self;
}

- (void)configProperty{
    self.stoped = YES;
    self.speed = 1.0;
    self.marqueeType = ZHMarqueeTypeLeft;
}

#pragma mark - getter

- (UIView *)animationView{
    if (!_animationView) {
        _animationView = [[UIView alloc] init];
        _animationView.backgroundColor = [UIColor clearColor];
    }
    return _animationView;
}

#pragma mark - setter

- (void)setTitleLabel:(UILabel *)titleLabel{
    _titleLabel = titleLabel;
    
    if (!titleLabel) {
        return;
    }
    
    CGSize maxSize = CGSizeMake(MAXFLOAT, self.bounds.size.height);
    CGSize fitSize = [titleLabel.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil].size;
    titleLabel.frame = (CGRect){CGPointZero,fitSize};
    
    self.animationView.frame = titleLabel.bounds;
    [self.animationView addSubview:titleLabel];
    
    self.frame = (CGRect){self.frame.origin,{self.bounds.size.width,fitSize.height}};
}

#pragma mark - animation

- (void)stopAnimation{
    self.stoped = YES;
    [self.animationView.layer removeAnimationForKey:@"animationViewPosition"];
}

- (void)startAnimation{
    self.stoped = NO;
    [self.animationView.layer removeAnimationForKey:@"animationViewPosition"];

    CGFloat selfWidth = self.bounds.size.width;
//    CGFloat selfHeight = self.bounds.size.height;
    CGFloat animationWidth = self.animationView.bounds.size.width;
    CGFloat animationHeight = self.animationView.bounds.size.height;
    
    CGPoint pointRight = CGPointMake(selfWidth + animationWidth / 2.0, animationHeight / 2.0);
    CGPoint pointLeft = CGPointMake(-animationWidth / 2.0, animationHeight / 2.0);
    CGPoint fromPoint = ((self.marqueeType == ZHMarqueeTypeLeft) ? pointRight : pointLeft);
    CGPoint toPoint = ((self.marqueeType == ZHMarqueeTypeLeft) ? pointLeft : pointRight);
    
    self.animationView.center = fromPoint;
    UIBezierPath *movePath    = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    [movePath addLineToPoint:toPoint];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path                 = movePath.CGPath;
    moveAnimation.removedOnCompletion  = YES;
    moveAnimation.duration             = animationWidth / 30.f * (1 / self.speed);
    moveAnimation.delegate             = self;
    [self.animationView.layer addAnimation:moveAnimation forKey:@"animationViewPosition"];
}

- (void)pauseAnimation {
    CFTimeInterval pausedTime = [self.animationView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.animationView.layer.speed               = 0.0;
    self.animationView.layer.timeOffset          = pausedTime;
}

- (void)resumeAnimation {
    CFTimeInterval pausedTime     = self.animationView.layer.timeOffset;
    self.animationView.layer.speed                   = 1.0;
    self.animationView.layer.timeOffset              = 0.0;
    self.animationView.layer.beginTime               = 0.0;
    CFTimeInterval timeSincePause = [self.animationView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.animationView.layer.beginTime               = timeSincePause;
}

#pragma mark - delegate

- (void)animationDidStart:(CAAnimation *)anim{
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag && !self.stoped) {
        
        [self startAnimation];
    }
}

@end
