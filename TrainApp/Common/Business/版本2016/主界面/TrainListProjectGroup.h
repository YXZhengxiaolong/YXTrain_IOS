//
//  TrainListProjectGroup.h
//  TrainApp
//
//  Created by ZLL on 2016/11/17.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YXTrainListRequest.h"
@interface TrainListProjectGroup : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray<YXTrainListRequestItem_body_train *> *items;
+ (NSArray<TrainListProjectGroup *> *)projectGroupsWithRawData:(YXTrainListRequestItem_body *)data;
@end
