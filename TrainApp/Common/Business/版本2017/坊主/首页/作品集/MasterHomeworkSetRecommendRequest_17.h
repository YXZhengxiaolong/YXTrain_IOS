//
//  MasterHomeworkSetRecommendRequest_17.h
//  TrainApp
//
//  Created by 郑小龙 on 2017/11/29.
//  Copyright © 2017年 niuzhaowang. All rights reserved.
//

#import "YXGetRequest.h"

@interface MasterHomeworkSetRecommendRequest_17 : YXGetRequest
@property (nonatomic, copy) NSString<Optional> *projectId;
@property (nonatomic, copy) NSString<Optional> *homeworkSetId;
@property (nonatomic, copy) NSString<Optional> *content;
@end
