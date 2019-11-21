//
//  WJHttpRequest.m
//  WJHttpRequest
//
//  Created by wangjie on 2019/11/21.
//  Copyright © 2019 wangjie. All rights reserved.
//

#import "WJHttpRequest.h"

@implementation WJHttpRequest

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.securityPolicy = [AFSecurityPolicy defaultPolicy];
        self.requestSerializer.timeoutInterval = 20;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/plain", nil];
    }
    return self;
}

+ (instancetype)sharedRequest {
    static id sharedRequest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedRequest = [[self alloc] init];
    });
    return sharedRequest;
}

+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    WJHttpRequest *request = [self sharedRequest];
    [request.requestSerializer setValue:value forHTTPHeaderField:field];
}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
     constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    return [[self sharedRequest] POST:URLString parameters:parameters constructingBodyWithBlock:block progress:uploadProgress success:success failure:failure];
}

+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(id)parameters
                     progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                      success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    return [[self sharedRequest] GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];
}

@end
