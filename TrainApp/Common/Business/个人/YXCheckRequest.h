//
//  YXCheckRequest.h
//  TrainApp
//
//  Created by 郑小龙 on 16/9/8.
//  Copyright © 2016年 niuzhaowang. All rights reserved.
//

#import "YXGetRequest.h"
@interface YXCheckRequestItem:HttpBaseRequestItem
@property (nonatomic, copy) NSString<Optional> *version;
@end
@interface YXCheckRequest : YXGetRequest

@end
