//
//  YXScorePhaseHeaderView.h
//  TrainApp
//
//  Created by niuzhaowang on 16/6/27.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXExamineRequest.h"

@interface YXScorePhaseHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) YXExamineRequestItem_body_leadingVo *data;
@end
