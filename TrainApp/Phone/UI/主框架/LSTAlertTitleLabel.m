//
//  LSTAlertTitleLabel.m
//  TrainApp
//
//  Created by ZLL on 2016/12/12.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "LSTAlertTitleLabel.h"

@implementation LSTAlertTitleLabel
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textColor = [UIColor colorWithHexString:@"334466"];
        self.font = [UIFont systemFontOfSize:15.0f];
        self.textAlignment = NSTextAlignmentCenter;
        self.numberOfLines = 0;
    }
    return self;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    NSRange range = NSMakeRange(0, text.length);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:range];
    self.attributedText = attributedString;
}
@end
