//
//  YXGuideCustomView.m
//  TrainApp
//
//  Created by 李五民 on 16/7/12.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "YXGuideCustomView.h"

#define kScreenSpaceHeight   [UIScreen mainScreen].bounds.size.height / 667.0f
@interface YXGuideCustomView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titileLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *startButton;

@end

@implementation YXGuideCustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.iconImageView = [[UIImageView alloc] init];
        [self addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.mas_equalTo(110.0f * kScreenSpaceHeight);
            make.size.mas_equalTo(CGSizeMake(215 * kScreenSpaceHeight , 215 * kScreenSpaceHeight));
        }];
        
        self.titileLabel = [[UILabel alloc] init];
        self.titileLabel.textColor = [UIColor colorWithHexString:@"0067be"];
        self.titileLabel.font = [UIFont boldSystemFontOfSize:27];
        [self addSubview:self.titileLabel];
        [self.titileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.iconImageView.mas_bottom).offset(80.0f * kScreenSpaceHeight);
        }];
        
        self.detailLabel = [[UILabel alloc] init];
        self.detailLabel.numberOfLines = 0;
        self.detailLabel.textColor = [UIColor colorWithHexString:@"999999"];
        self.detailLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.detailLabel];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.titileLabel.mas_bottom).offset(21.0f);
        }];
        
        self.startButton = [[UIButton alloc] init];
        self.startButton.layer.borderWidth = 1;
        self.startButton.layer.cornerRadius = YXTrainCornerRadii;
        self.startButton.layer.borderColor = [[UIColor colorWithHexString:@"2582d0"] CGColor];
        [self.startButton setTitle:@"开始体验" forState:UIControlStateNormal];
        [self.startButton setTitleColor:[UIColor colorWithHexString:@"0067be"] forState:UIControlStateNormal];
        [self.startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [self.startButton setBackgroundImage:[UIImage yx_imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [self.startButton setBackgroundImage:[UIImage yx_imageWithColor:[UIColor colorWithHexString:@"0067be"]] forState:UIControlStateHighlighted];
        self.startButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.startButton addTarget:self action:@selector(startButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.startButton];
        [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.detailLabel.mas_bottom).offset(20.0f);
            make.size.mas_offset(CGSizeMake(120, 34));
        }];
    }
    return self;
}

- (void)configWithGuideModel:(YXGuideModel *)guideModel {
    self.titileLabel.text = guideModel.guideTitle;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:guideModel.guideDetail];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, guideModel.guideDetail.length)];
    self.detailLabel.attributedText = attributedString;
    self.startButton.hidden = !guideModel.isShowButton;
    self.iconImageView.image = [UIImage imageNamed:guideModel.guideImageString];
}

- (void)startButtonClicked {
    if (self.startButtonClickedBlock) {
        self.startButtonClickedBlock();
    }
}

@end
