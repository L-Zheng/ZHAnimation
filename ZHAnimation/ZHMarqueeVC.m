//
//  ZHMarqueeVC.m
//  ZHAnimation
//
//  Created by 李保征 on 2018/2/27.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "ZHMarqueeVC.h"
#import "ZHMarqueeView.h"

@interface ZHMarqueeVC ()

@end

@implementation ZHMarqueeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ZHMarqueeVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    ZHMarqueeView *view = [[ZHMarqueeView alloc] initWithFrame:CGRectMake(100, 300, 200, 0)];
    view.backgroundColor = [UIColor cyanColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"爱爱奶女爱那若怒uua";
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    view.titleLabel = titleLabel;
    
    [self.view addSubview:view];
    
    [view startAnimation];
}

@end
