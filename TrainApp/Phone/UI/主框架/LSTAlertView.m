//
//  LSTAlertView.m
//  TrainApp
//
//  Created by ZLL on 2016/12/12.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "LSTAlertView.h"
CGFloat const kDefaultContentViewWith = 270.0f;
CGFloat const kDefaultContentViewHeight = 155.0f;

@interface LSTAlertButtonItem : NSObject
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) ButtonActionBlock block;
@end

@implementation LSTAlertButtonItem
@end

@interface LSTAlertView ()
@property (nonatomic, strong) NSMutableArray<LSTAlertButtonItem *> *alertButtonItems;//有1~2个按钮
@end

@implementation LSTAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.alertButtonItems = [NSMutableArray array];
    }
    return self;
}

#pragma mark - addButton
- (void)addButtonWithTitle:(NSString *)title style:(LSTAlertActionStyle)style action:(ButtonActionBlock)buttonActionBlock {
    if (self.alertButtonItems.count > 2) {
        return;
    }
    LSTAlertButton *button = [[LSTAlertButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.style = style;
    LSTAlertButtonItem *item = [[LSTAlertButtonItem alloc]init];
    item.button = button;
    item.block = buttonActionBlock;
    [self.alertButtonItems addObject:item];
}

- (void)buttonAction:(LSTAlertButton *)sender {
    [self hide];
    [self.alertButtonItems enumerateObjectsUsingBlock:^(LSTAlertButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([sender isEqual:obj.button]) {
            BLOCK_EXEC(obj.block);
            *stop = YES;
        }
    }];
}

#pragma mark - show
- (void)show {
    [self show:YES];
}

- (void)show:(BOOL)animated {
    [self showInView:[UIApplication sharedApplication].keyWindow animated:animated] ;
}

- (void)showInView:(UIView *)view {
    [self showInView:view animated:YES];
}

- (void)showInView:(UIView *)view animated:(BOOL)animated {
    LayoutBlock block = ^(AlertView *view) {
        [view.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_offset(kDefaultContentViewWith);
            //make.size.mas_equalTo(CGSizeMake(kDefaultContentViewWith, kDefaultContentViewHeight));
        }];
        if (animated) {
            self.alpha = 0.3;
            NSTimeInterval duration = animated ? 0.3f : 0;
            [UIView animateWithDuration:duration animations:^{
                self.alpha = 1.f;
            }];
        }
    };
    if (!self.contentView) {
        self.contentView = [self generateDefaultView];
    }
    [self showInView:view withLayout:block];
}

#pragma mark - defaultContentView
- (UIView *)generateDefaultView {
    UIView *defaultView = [[UIView alloc]init];
    defaultView.backgroundColor = [UIColor whiteColor];
    defaultView.layer.cornerRadius = YXTrainCornerRadii;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:self.imageName];
    
    LSTAlertTitleLabel *titleLabel = [[LSTAlertTitleLabel alloc]init];
    if (self.attributedString) {
        titleLabel.attributedText = self.attributedString;
    }else {
        titleLabel.text = self.title;
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"eceef2"];
    
    [defaultView addSubview:imageView];
    [defaultView addSubview:titleLabel];
    [defaultView addSubview:lineView];
    
    if (self.alertButtonItems.count > 2.0 || self.alertButtonItems.count == 0) {
        NSAssert(self.alertButtonItems.count, @"按键数目不能超过2个,也不能为空");
    }else{
        if (self.alertButtonItems.count == 1) {
            UIButton *button = self.alertButtonItems.firstObject.button;
            [defaultView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(defaultView.mas_bottom);
                make.left.right.equalTo(defaultView);
                make.height.mas_offset(60.0f);
                make.top.equalTo(lineView.mas_bottom);
            }];
        }else{
            UIButton *buttonOne = self.alertButtonItems.firstObject.button;
            buttonOne.tag = 0;
            [defaultView addSubview:buttonOne];
            [buttonOne mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(defaultView.mas_left).offset(30.0f);
                make.height.mas_offset(29.0f);
                make.width.mas_offset(75.0f);
                make.bottom.equalTo(defaultView.mas_bottom).offset(-15.5f);
                make.top.equalTo(lineView.mas_bottom).offset(15.5f);
            }];
            UIButton *buttonTwo = self.alertButtonItems.lastObject.button;
            buttonTwo.tag = 1;
            [defaultView addSubview:buttonTwo];
            [buttonTwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(defaultView.mas_right).offset(-30.0f);
                make.height.mas_offset(29.0f);
                make.width.mas_offset(75.0f);
                make.bottom.equalTo(defaultView.mas_bottom).offset(-15.5f);
                make.top.equalTo(lineView.mas_bottom).offset(15.5f);
            }];
        }
    }
    

    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90.0f, 90.0f));
        make.bottom.equalTo(defaultView.mas_top).offset(37.0f);
        make.centerX.equalTo(defaultView.mas_centerX);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(3.0f);
        make.centerX.equalTo(imageView.mas_centerX);
        make.width.equalTo(defaultView.mas_width).offset(-30.0f);
        make.height.mas_greaterThanOrEqualTo(50.0f);
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(defaultView);
        make.bottom.equalTo(titleLabel.mas_bottom).offset(15.0f);
        make.height.mas_offset(1/[UIScreen mainScreen].scale);
    }];
    
    return defaultView;
}

@end
