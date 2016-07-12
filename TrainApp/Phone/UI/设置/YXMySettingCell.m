//
//  YXMySettingCell.m
//  TrainApp
//
//  Created by 郑小龙 on 16/7/13.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "YXMySettingCell.h"
@interface YXMySettingCell()
{
    UILabel *_titleLabel;
    UIImageView *_imageView;
}
@end
@implementation YXMySettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - setup UI
- (void)setupUI{
    UIView *selectedBgView = [[UIView alloc]init];
    selectedBgView.backgroundColor = [UIColor colorWithHexString:@"f2f6fa"];
    self.selectedBackgroundView = selectedBgView;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _titleLabel.textColor = [UIColor colorWithHexString:@"334466"];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15.0f);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12.0f);
        make.height.width.mas_equalTo(16.0f);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}
- (void)reloadWithText:(NSString *)text
             imageName:(NSString *)imageName{
    _titleLabel.text = text;
    _imageView.image = [UIImage imageNamed:imageName];
}
@end
