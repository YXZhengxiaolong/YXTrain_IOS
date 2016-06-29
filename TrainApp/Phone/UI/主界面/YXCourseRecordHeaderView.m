//
//  YXCourseRecordHeaderView.m
//  TrainApp
//
//  Created by niuzhaowang on 16/6/30.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "YXCourseRecordHeaderView.h"

@interface YXCourseRecordHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation YXCourseRecordHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.backgroundColor = [UIColor redColor];
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(3);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.top.mas_equalTo(14);
    }];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"a1a7ae"];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imgView.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(imgView.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
}

@end
