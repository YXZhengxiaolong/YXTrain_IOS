//
//  ActivityStepHeaderView.m
//  TrainApp
//
//  Created by 郑小龙 on 16/11/15.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "ActivityStepHeaderView.h"
#import "CoreTextViewHandler.h"
#import "YXGradientView.h"
@interface ActivityStepHeaderView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) DTAttributedTextContentView *htmlView;
@property (nonatomic, strong) UIButton *openCloseButton;
@property (nonatomic, strong) CoreTextViewHandler *coreTextHandler;
@property (nonatomic, strong) YXGradientView *gradientView;


@property (nonatomic, copy) ActivityHtmlOpenAndCloseBlock openCloseBlock;
@property (nonatomic, copy) ActivityHtmlHeightChangeBlock heightChangeBlock;
@end
@implementation ActivityStepHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self setupLayout];
    }
    return self;
}

#pragma mark - setupUI
- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor colorWithHexString:@"dfe2e6"];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(5.0f);
        make.top.equalTo(self.mas_top);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor colorWithHexString:@"334466"];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"eceef2"];
    [self addSubview:lineView];
    self.descriptionLabel = [[UILabel alloc] init];
    self.descriptionLabel.textColor = [UIColor colorWithHexString:@"a1a7ae"];
    self.descriptionLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    self.descriptionLabel.text = @"步骤描述";
    self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.descriptionLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.descriptionLabel];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_offset(1.0f / [UIScreen mainScreen].scale);
        make.centerY.equalTo(self.descriptionLabel.mas_centerY);
    }];
    
    self.htmlView = [[DTAttributedTextContentView alloc] init];
    self.htmlView.clipsToBounds = YES;
    [self addSubview:self.htmlView];
    self.coreTextHandler = [[CoreTextViewHandler alloc]initWithCoreTextView:self.htmlView maxWidth:kScreenWidth - 50.0f];
    WEAK_SELF
    self.coreTextHandler.heightChangeBlock = ^(CGFloat height) {
        STRONG_SELF
        self ->_htmlHeight = height;
        [self updateHtmlViewWithHeight:height];
        if (height < 300.0f) {
            BLOCK_EXEC(self.heightChangeBlock,height);
        }
    };
    
    self.openCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.openCloseButton.layer.cornerRadius = YXTrainCornerRadii;
    self.openCloseButton.layer.borderWidth = 1.0f;
    self.openCloseButton.layer.borderColor = [UIColor colorWithHexString:@"0070c9"].CGColor;
    self.openCloseButton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.openCloseButton setTitle:@"查看全文" forState:UIControlStateNormal];
    [self.openCloseButton setTitleColor:[UIColor colorWithHexString:@"0067be"] forState:UIControlStateNormal];
    [self.openCloseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.openCloseButton setBackgroundImage:[UIImage yx_imageWithColor:[UIColor colorWithHexString:@"0070c9"]] forState:UIControlStateHighlighted];
    [self.openCloseButton addTarget:self action:@selector(openCloseButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.openCloseButton];
    self.gradientView = [[YXGradientView alloc] initWithColor:[UIColor whiteColor] orientation:YXGradientBottomToTop];
    [self.htmlView addSubview:self.gradientView];
}
- (void)setupLayout {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25.0f);
        make.right.equalTo(self.mas_right).offset(-25.0f);
        make.top.equalTo(self.mas_top).offset(37.0f + 5.0f);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(40.0f);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_offset(100.0f);
    }];
    
    [self.htmlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionLabel.mas_bottom).offset(22.0f);
        make.left.equalTo(self.mas_left).offset(25.0f);
        make.right.equalTo(self.mas_right).offset(-25.0f);
        make.bottom.equalTo(self.mas_bottom).offset (-61.0f);
    }];
    [self.gradientView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.htmlView.mas_bottom);
        make.height.mas_offset(60.0f);
    }];
    
    [self.openCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(80.0f, 24.0f));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-20.0f);
    }];
}
- (void)updateHtmlViewWithHeight:(CGFloat)height {
    if (height < 300.0f) {
        [self.htmlView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.descriptionLabel.mas_bottom).offset(22.0f);
            make.left.equalTo(self.mas_left).offset(25.0f);
            make.right.equalTo(self.mas_right).offset(-25.0f);
            make.bottom.equalTo(self.mas_bottom).offset (-3.0f);
        }];
        self.openCloseButton.hidden = YES;
        self.gradientView.hidden = YES;
    }
}
- (void)relayoutHtmlText{
    [self.htmlView relayoutText];
}

#pragma mark - Actions
- (void)openCloseButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.gradientView.hidden = YES;
        [sender setTitle:@"收起" forState:UIControlStateNormal];
    }else {
        self.gradientView.hidden = NO;
        [sender setTitle:@"查看全文" forState:UIControlStateNormal];
    }
    BLOCK_EXEC(self.openCloseBlock,sender.selected);
}

#pragma mark - set
- (void)setActivityHtmlOpenAndCloseBlock:(ActivityHtmlOpenAndCloseBlock)block {
    self.openCloseBlock = block;
}
- (void)setActivityHtmlHeightChangeBlock:(ActivityHtmlHeightChangeBlock)block {
    self.heightChangeBlock = block;
}
- (void)setActivity:(ActivityListRequestItem_body_activity *)activity{
    _activity = activity;
    self.titleLabel.text = @"是电风扇的恢复了华盛顿绿肥红瘦了";
    NSString *readmePath = [[NSBundle mainBundle] pathForResource:@"Image" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:readmePath
                                               encoding:NSUTF8StringEncoding
                                                  error:NULL];
    NSData *data = [html dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *string = [[NSAttributedString alloc] initWithHTMLData:data options:[CoreTextViewHandler defaultCoreTextOptions]documentAttributes:nil];
    self.htmlView.attributedString = string;
}

@end
