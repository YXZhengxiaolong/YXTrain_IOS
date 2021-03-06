//
//  MasterCircleDisplayView_17.h
//  TrainApp
//
//  Created by 郑小龙 on 2017/11/15.
//  Copyright © 2017年 niuzhaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXCircleView.h"
#import "YXBackgroundCircleView.h"
@interface MasterCircleDisplayView_17 : UIView
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, strong) YXCircleView *circleView;
@property (nonatomic, strong) YXBackgroundCircleView *bgView;
@end
