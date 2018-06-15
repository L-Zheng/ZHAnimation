//
//  ZHMarqueeView.h
//  ZHView
//
//  Created by 李保征 on 2018/2/26.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZHMarqueeType) {
    ZHMarqueeTypeLeft     = 0,
    ZHMarqueeTypeRight      = 1,
};

@interface ZHMarqueeView : UIView

@property (nonatomic,assign) BOOL stoped;

@property (nonatomic,assign) CGFloat speed;

@property (nonatomic,assign) ZHMarqueeType marqueeType;

@property (nonatomic,strong) UILabel *titleLabel;

- (void)stopAnimation;
- (void)startAnimation;
- (void)pauseAnimation;
- (void)resumeAnimation;

@end
