//
//  YXCourseDetailRequest.m
//  TrainApp
//
//  Created by niuzhaowang on 16/6/30.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "YXCourseDetailRequest.h"

@implementation YXCourseDetailRequestItem

@end

@implementation YXCourseDetailRequest
- (instancetype)init
{
    if (self = [super init]) {
        self.urlHead = [[YXConfigManager sharedInstance].server stringByAppendingString:@"api/guopei/myCourseDetail"];
    }
    return self;
}
@end
