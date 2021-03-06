//
//  ChangeProjectGuideView.m
//  TrainApp
//
//  Created by ZLL on 2016/12/28.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "ChangeProjectGuideView.h"

@implementation ChangeProjectGuideView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.72f];
        [self setupUIAndLayoutInterface];
    }
    return self;
}

- (void)setupUIAndLayoutInterface{
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"切换项目箭头"]];
    [self addSubview:arrowImageView];
    
    UIImageView *descriptionImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"点击可以切换当前显示的项目"]];
    [self addSubview:descriptionImageView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"项目切换-我知道了-按钮"]];
    [self addSubview:imageView];
    
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kVerticalNavBarHeight - 4.0f);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [descriptionImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(arrowImageView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(340, 45));
    }];
    
    [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(descriptionImageView.mas_bottom).offset(50);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(170, 65));
    }];
}
@end
