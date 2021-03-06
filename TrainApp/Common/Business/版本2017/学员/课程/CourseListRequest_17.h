//
//  CourseListRequest_17.h
//  TrainApp
//
//  Created by 郑小龙 on 2017/7/12.
//  Copyright © 2017年 niuzhaowang. All rights reserved.
//

#import "YXGetRequest.h"
#import "CourseCenterConditionRequest_17.h"
@protocol CourseListRequest_17Item_SearchTerm_Stage @end
@interface CourseListRequest_17Item_SearchTerm_Stage : JSONModel
@property (nonatomic, copy) NSString<Optional> *stageID;
@property (nonatomic, copy) NSString<Optional> *stageName;
@end

@protocol CourseListRequest_17Item_SearchTerm_MockSegment_Grade <NSObject>
@end

@interface CourseListRequest_17Item_SearchTerm_MockSegment_Grade : JSONModel
@property (nonatomic, copy) NSString<Optional> *gradeID;
@property (nonatomic, copy) NSString<Optional> *gradeName;
@end
@protocol CourseListRequest_17Item_SearchTerm_MockSegment_Chapter <NSObject>

@end
@interface CourseListRequest_17Item_SearchTerm_MockSegment_Chapter : JSONModel
@property (nonatomic, copy) NSString<Optional> *chapterID;
@property (nonatomic, copy) NSString<Optional> *chapterName;
@end

@protocol CourseListRequest_17Item_SearchTerm_MockSegment <NSObject>

@end
@interface CourseListRequest_17Item_SearchTerm_MockSegment : JSONModel
@property (nonatomic, copy) NSString<Optional> *segmentID;
@property (nonatomic, copy) NSString<Optional> *segmentName;
@property (nonatomic, strong) NSMutableArray<CourseListRequest_17Item_SearchTerm_MockSegment_Grade,Optional>*grade;
@property (nonatomic, strong) NSMutableArray<CourseListRequest_17Item_SearchTerm_MockSegment_Chapter,Optional>*chapter;
@end



@interface CourseListRequest_17Item_Objs_Quiz : JSONModel
@property (nonatomic, copy) NSString<Optional> *finish;
@property (nonatomic, copy) NSString<Optional> *total;
@end

@interface CourseListRequest_17Item_Objs_Content : JSONModel
@property (nonatomic, copy) NSString<Optional> *cinfo;
@property (nonatomic, copy) NSString<Optional> *teacher;
@property (nonatomic, copy) NSString<Optional> *imgUrl;
@end

@protocol CourseListRequest_17Item_Objs <NSObject>
@end

@interface CourseListRequest_17Item_Objs : JSONModel
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *trainingID;//
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *studyCode;//
@property (nonatomic, copy) NSString<Optional> *segmentCode;//
@property (nonatomic, copy) NSString<Optional> *template;
@property (nonatomic, copy) NSString<Optional> *objID;//
@property (nonatomic, strong) CourseListRequest_17Item_Objs_Content<Optional> *content;
@property (nonatomic, copy) NSString<Optional> *timeLength;//课程中心使用(课程中心单位为秒)
@property (nonatomic, copy) NSString<Optional> *timeLengthSec;//观看课程使用(观看课程单位为秒)
@property (nonatomic, copy) NSString<Optional> *speaker;
@property (nonatomic, copy) NSString<Optional> *score;
@property (nonatomic, copy) NSString<Optional> *isSelected;
@property (nonatomic, copy) NSString<Optional> *pic;
@property (nonatomic, copy) NSString<Optional> *studyName;
@property (nonatomic, copy) NSString<Optional> *segmentName;
@property (nonatomic, copy) NSString<Optional> *teacher;
@property (nonatomic, copy) NSString<Optional> *credit;
@property (nonatomic, copy) NSString<Optional> *cinfo;
@property (nonatomic, copy) NSString<Optional> *time;
@property (nonatomic, copy) NSString<Optional> *stageID;
@property (nonatomic, copy) NSString<Optional> *isFinish;
@property (nonatomic, copy) NSString<Optional> *courseType;
@property (nonatomic, copy) NSString<Optional> *isSupportApp;
@end
@interface CourseListRequest_17Item_Scheme_Scheme : JSONModel
@property (nonatomic, copy) NSString<Optional> *toolID;
@property (nonatomic, copy) NSString<Optional> *finishNum;
@property (nonatomic, copy) NSString<Optional> *finishScore;
@property (nonatomic, copy) NSString<Optional> *type;
@property (nonatomic, copy) NSString<Optional> *passFinishScore;
@property (nonatomic, copy) NSString<Optional> *passScore;
@property (nonatomic, copy) NSString<Optional> *descripe;
@end
@interface CourseListRequest_17Item_Scheme_Process : JSONModel
@property (nonatomic, copy) NSString<Optional> *userFinishNum;
@property (nonatomic, copy) NSString<Optional> *userFinishScore;
@property (nonatomic, copy) NSString<Optional> *userPassScore;
@property (nonatomic, copy) NSString<Optional> *isPass;
@end
@protocol CourseListRequest_17Item_Scheme <NSObject>
@end
@interface CourseListRequest_17Item_Scheme : JSONModel
@property (nonatomic, strong) CourseListRequest_17Item_Scheme_Process<Optional> *process;
@property (nonatomic, strong) CourseListRequest_17Item_Scheme_Scheme<Optional> *scheme;
@end

@interface CourseListRequest_17Item_SearchTerm_ModuleVo : JSONModel
@property (nonatomic, copy) NSString<Optional> *moduleVoID;
@property (nonatomic, copy) NSString<Optional> *name;
@property (nonatomic, copy) NSString<Optional> *stageID;
@end
@interface CourseListRequest_17Item_SearchTerm_DefaultValue : JSONModel
@property (nonatomic, copy) NSString<Optional> *segment;
@property (nonatomic, copy) NSString<Optional> *study;
@end
@interface CourseListRequest_17Item_SearchTerm : HttpBaseRequestItem
@property (nonatomic, strong) CourseListRequest_17Item_SearchTerm_ModuleVo<Optional> *moduleVo;
@property (nonatomic, strong) CourseListRequest_17Item_SearchTerm_DefaultValue<Optional> *defaultValue;
@property (nonatomic, copy) NSString<Optional> *isLockStudy;
@property (nonatomic, strong) NSArray<CourseCenterConditionRequest_17Item_CourseTypes, Optional> *coursetypes;
@property (nonatomic, strong) NSArray<CourseListRequest_17Item_SearchTerm_Stage, Optional> *stages;
@property (nonatomic, strong) NSArray<CourseListRequest_17Item_Scheme,Optional> *scheme;
/**
 内部解析用 读取使用 segmentModel
 */
@property (nonatomic, strong) NSDictionary<Optional> *segments;
/**
 内部解析用 读取使用 segmentModel
 */
@property (nonatomic, strong) NSDictionary<Optional> *studys;
@property (nonatomic, strong) NSMutableArray<CourseListRequest_17Item_SearchTerm_MockSegment, Optional> *segmentModel;
@property (nonatomic, strong) NSMutableArray<Optional> *selectedMutableArray;//数组@[学段,学科]
@end

@interface CourseListRequest_17Item : HttpBaseRequestItem
@property (nonatomic, strong) CourseListRequest_17Item_SearchTerm<Optional> *searchTerm;
@property (nonatomic, strong) NSArray<CourseListRequest_17Item_Scheme,Optional> *scheme;
@property (nonatomic, copy) NSString<Optional> *descr;
@property (nonatomic, strong) NSArray<CourseListRequest_17Item_Objs, Optional> *objs;
@property (nonatomic, copy) NSString<Optional> *count;
@property (nonatomic, copy) NSString<Optional> *page;
@property (nonatomic, copy) NSString<Optional> *totalPage;
@property (nonatomic, copy) NSString<Optional> *stageStatus;
@end

@interface CourseListRequest_17 : YXGetRequest
@property (nonatomic, copy) NSString<Optional> *projectID;
@property (nonatomic, copy) NSString<Optional> *stageID;
@property (nonatomic, copy) NSString<Optional> *study;//学科id，默认值0
@property (nonatomic, copy) NSString<Optional> *segment;//学段id，默认值0
@property (nonatomic, copy) NSString<Optional> *themeID;//主题 id，有主题时必填，默认为0
@property (nonatomic, copy) NSString<Optional> *layerID;//主题 id，有主题时必填，默认为0
@property (nonatomic, copy) NSString<Optional> *type;//101：选修， 102：必修，默认值0
@property (nonatomic, copy) NSString<Optional> *page;//页数
@property (nonatomic, copy) NSString<Optional> *limit;//每页数量
@property (nonatomic, copy) NSString<Optional> *role;
@property (nonatomic, copy) NSString<Optional> *category;
@property (nonatomic, copy) NSString<Optional> *status;
@end
