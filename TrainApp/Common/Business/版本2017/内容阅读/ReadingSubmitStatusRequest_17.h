//
//  ReadingSubmitStatusRequest_17.h
//  TrainApp
//
//  Created by 郑小龙 on 2017/7/24.
//  Copyright © 2017年 niuzhaowang. All rights reserved.
//

#import "YXGetRequest.h"

@interface ReadingSubmitStatusRequest_17 : YXGetRequest
@property (nonatomic, strong) NSString<Optional> *projectID;
@property (nonatomic, strong) NSString<Optional> *stageID;
@property (nonatomic, strong) NSString<Optional> *contentID;
@end
