//
//  MasterCourseRecordListTableHeaderView_17.h
//  TrainApp
//
//  Created by 郑小龙 on 2017/12/4.
//  Copyright © 2017年 niuzhaowang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseListRequest_17.h"
@interface MasterCourseRecordListTableHeaderView_17 : UIView
@property (nonatomic, strong) CourseListRequest_17Item_Scheme *scheme;
@property (nonatomic, copy) void(^masterCourseRecordButtonBlock)(UIButton *sender);
@end
