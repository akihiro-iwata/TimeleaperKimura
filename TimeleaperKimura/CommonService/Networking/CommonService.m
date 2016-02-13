//
//  CommonService.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonService.h"

#import "NSObject+RunBlockTasks.h"

@implementation CommonService

// HTTP Session Manager Configuration
static const NSTimeInterval DEFAULT_TIMEOUT_FOR_REQUEST     = 30.0;
static const NSTimeInterval DEFAULT_TIMEOUT_FOR_RESOURCE    = 60.0;

#pragma mark -
#pragma mark Initializations

- (instancetype)initWithBaseURL:(NSURL *)url
{
    // get global proxy settings
    CFDictionaryRef proxySettingsRef = CFNetworkCopySystemProxySettings();
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.connectionProxyDictionary = CFBridgingRelease(proxySettingsRef);
    configuration.timeoutIntervalForRequest = DEFAULT_TIMEOUT_FOR_REQUEST;
    configuration.timeoutIntervalForResource = DEFAULT_TIMEOUT_FOR_RESOURCE;
    
    if ((self.sessionManager = [super initWithBaseURL:url sessionConfiguration:configuration])){
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        self.sessionManager.responseSerializer = responseSerializer;
        
        // responseSelializer (default:AFJSONResponseSerializer)
        // requestSerializer (default:AFHTTPRequestSerializer)
    }
    
    // Enable network activity indicator
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    // start monitoring of network reachability
    static dispatch_once_t  once;
    dispatch_once(&once, ^{
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    
    return self;
}

#pragma mark -
#pragma mark CallAPI(Common)

// Start HTTP GET request task
//
// success and failure callback blocks is called on main thread
// then run it in background to avoid blocking main UI thread
- (void)GET:(NSString*)relativePath withParameters:(NSDictionary*)parameters success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSURLSessionDataTask *task = [self.sessionManager GET:relativePath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
            [self dispatch_async_global:^{
                success(responseObject);
            }];
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        [self dispatch_async_global:^{
            failure(error);
        }];
    }];
}

// Start HTTP POST request task
//
// success and failure callback blocks is called on main thread
// then run it in background to avoid blocking main UI thread
- (void)POST:(NSString*)relativePath withParameters:(NSDictionary*)parameters success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    NSURLSessionDataTask *task = [self.sessionManager POST:relativePath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self dispatch_async_global:^{
            success(responseObject);
        }];
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        [self dispatch_async_global:^{
            failure(error);
        }];
    }];
}

- (void)PATCH:(NSString*)relativePath withParameters:(NSString*)parameters success:(void(^)(id response))success failure:(void(^)(NSError *error))failure
{
    
    NSURLSessionDataTask *task = [self.sessionManager PATCH:relativePath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self dispatch_async_global:^{
            success(responseObject);
        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self dispatch_async_global:^{
            failure(error);
        }];
    }];
/*
    NSURLSessionDataTask *task = [self.sessionManager PATCH:relativePath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        [self dispatch_async_global:^{
            success(responseObject);
        }];
    }failure:^(NSURLSessionDataTask *task, NSError *error){
        [self dispatch_async_global:^{
            failure(error);
        }];
    }];
*/
}


@end
