//
//  HttpBaseRequest.m
//  YanXiuStudentApp
//
//  Created by Lei Cai on 7/2/15.
//  Copyright (c) 2015 yanxiu. All rights reserved.
//

#import "HttpBaseRequest.h"
#import "YXMockManager.h"
#import "AppDelegate.h"
#pragma mark - Url Arguments Category : NSString & NSDictionary
@interface NSDictionary (UrlArgumentsAdditions)
- (NSString *)httpArgumentsString;
@end

@interface NSString (UrlArgumentsAdditions)
- (NSString*)stringByEscapingForURLArgument;
- (NSString*)stringByUnescapingFromURLArgument;
@end



@implementation NSString (UrlArgumentsAdditions)
- (NSString*)stringByEscapingForURLArgument {
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8);
}

- (NSString*)stringByUnescapingFromURLArgument {
    NSMutableString *resultString = [NSMutableString stringWithString:self];
    [resultString replaceOccurrencesOfString:@"+"
                                  withString:@" "
                                     options:NSLiteralSearch
                                       range:NSMakeRange(0, [resultString length])];
    return [resultString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
@end

@implementation NSDictionary (UrlArgumentsAdditions)
- (NSString *)httpArgumentsString {
    NSMutableArray* arguments = [NSMutableArray arrayWithCapacity:[self count]];
    for (NSString *key in self.allKeys) {
        [arguments addObject:[NSString stringWithFormat:@"%@=%@",
                              [key stringByEscapingForURLArgument],
                              [[[self objectForKey:key] description] stringByEscapingForURLArgument]]];
    }
    
    return [arguments componentsJoinedByString:@"&"];
}
@end



#pragma mark -
@implementation HttpBaseRequestItem_Status
@end

@implementation HttpBaseRequestItem
@end

@implementation HttpBaseRequest
- (ASIHTTPRequest *)request {
    return nil; // 子类实现, GET / POST / UPLOAD
}

- (void)updateRequestUrlAndParams {
    
}

- (void)startRequestWithRetClass:(Class)retClass
                andCompleteBlock:(HttpRequestCompleteBlock)completeBlock {
    self->_completeBlock = completeBlock;
    self->_retClass = retClass;
    
    NSString *key = NSStringFromClass([self class]);
    if ([[LSTSharedInstance sharedInstance].mockParser hasMockDataForKey:key]) {
        self->_isMock = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([LSTSharedInstance sharedInstance].mockParser.timeUse * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *json = [[LSTSharedInstance sharedInstance].mockParser mockDataForKey:key];
            [self dealWithResponseJson:json];
        });
        return;
    }

    
    self->_isMock = NO;
    [self updateRequestUrlAndParams];
    DDLogWarn(@"request : %@", [self request].url);
    @weakify(self);
    [[self request] setCompletionBlock:^{
        @strongify(self); if (!self) return;
        NSString *json = [[NSString alloc] initWithData:[self request].responseData encoding:NSUTF8StringEncoding];
        [self dealWithResponseJson:json];
    }];
    [[self request] setFailedBlock:^{
        @strongify(self); if (!self) return;
        NSError *error = [self request].error;
        if (error
            && [error.domain isEqualToString:NetworkRequestErrorDomain]) {
            NSString *title = @"";
            if (error.code == ASIConnectionFailureErrorType) {
                title = @"网络异常,请稍后重试";
            } else if (error.code == ASIRequestTimedOutErrorType) {
                title = @"请求超时,请稍后重试";
            }
            error = [NSError errorWithDomain:NetworkRequestErrorDomain code:ASIConnectionFailureErrorType userInfo:@{NSLocalizedDescriptionKey:title}]; // 网络异常提示
        }
        self->_completeBlock(nil, error, self->_isMock);
    }];
    
    [[self request] startAsynchronous];
}

- (void)stopRequest {
    [[self request] clearDelegatesAndCancel];
}

// 约定server返回的业务逻辑错误为非负整数
- (void)dealWithResponseJson:(NSString *)json
{

}

#pragma mark - private
- (NSDictionary *)_paramDict {
    NSMutableDictionary *paramDict = [NSMutableDictionary dictionary];
    NSDictionary *dict = [self toDictionary];
    for (NSString *key in [dict allKeys]) {
        id value = [dict valueForKey:key];
        if (isEmpty(value) && [value isKindOfClass:[NSNull class]]) {
            continue;
        }
        [paramDict setValue:value forKey:key];
    }
    return [NSDictionary dictionaryWithDictionary:paramDict];
}

- (NSString *)_generateFullUrl {
    NSDictionary *paramDict = [self _paramDict];
    NSString *url = self.urlHead;
    if (!isEmpty(paramDict)) {
        url = [url stringByAppendingString:@"?"];
        url = [url stringByAppendingString:[paramDict httpArgumentsString]];
    }
    return url;
}

+ (BOOL)propertyIsIgnored:(NSString *)propertyName
{
    if ([propertyName isEqualToString: @"retryTimes"]) return YES;
    if ([propertyName isEqualToString: @"retryTimeinterval"]) return YES;
    if ([propertyName isEqualToString: @"request"]) return YES;
    if ([propertyName isEqualToString: @"completionBlock"]) return YES;
    if ([propertyName isEqualToString: @"requestType"]) return YES;
    if ([propertyName isEqualToString: @"bNeedRecord"]) return YES;
    return NO;
}

@end
