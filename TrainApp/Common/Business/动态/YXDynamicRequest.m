//
//  YXDynamicRequest.m
//  TrainApp
//
//  Created by 郑小龙 on 16/9/13.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "YXDynamicRequest.h"
@implementation YXDynamicRequestItem

@end


@implementation YXDynamicRequest
- (instancetype)init
{
    if (self = [super init]) {
        self.urlHead = [[YXConfigManager sharedInstance].server stringByAppendingString:@" "];
    }
    return self;
}
@end
