//
//  TimeleaperKimuraService.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "TimeleaperKimuraService.h"

#import "CommonDTO.h"

// xx base URL
static NSString *xxBaseURL = @"https://timeleaperkimura.herokuapp.com/api/";

// xx Endpoint
static NSString *v1Message = @"v1/messages";

// slack base URL
static NSString *slackBaseURL = @"https://slack.com/";
static NSString *tokenURL = @"api/oauth.access";
static NSString *channelList = @"api/channels.list";
static NSString *rtmStart = @"api/rtm.start";

@implementation TimeleaperKimuraService

#pragma mark -
#pragma mark Singleton
+ (CommonService*)xxAPIServiceShared
{
    static CommonService *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] initWithBaseURL:[NSURL URLWithString:xxBaseURL]];
    });
    
    return _shared;
}

+ (CommonService*)slackShared
{
    static CommonService *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[self alloc] initWithBaseURL:[NSURL URLWithString:slackBaseURL]];
    });
    
    return _shared;
}

+ (CommonWebSocketService*)slackWebSocketShared:(NSString*)url
{
    static CommonWebSocketService *_shared = nil;
    _shared = [[CommonWebSocketService alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    return _shared;
}

#pragma mark -
#pragma mark OAuth
+ (void)requestOAuthToken:(OAuthAuthorizationRequest*)request success:(void(^)(OAuthAuthorizationResponse*))success failure:(void(^)(NSError *error))failure{
    
    CommonService *service = [self slackShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;
    
    [service GET:[slackBaseURL stringByAppendingString:tokenURL] withParameters:[request toDictionary] success:^(id response) {
        responseDTO = [[OAuthAuthorizationResponse alloc]initWithDictionary:response error:&error];
        OAuthAuthorizationResponse *customResponse = (OAuthAuthorizationResponse*)responseDTO;
        success(customResponse);
    } failure:failure];
    
}

#pragma mark -
#pragma mark API Endpoint
+ (void)fetchxxAPI:(xxAPIRequest*)request success:(void(^)(xxAPIResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self xxAPIServiceShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;

    [service POST:[xxBaseURL stringByAppendingString:v1Message] withParameters:[request toDictionary] success:^(id response){
        responseDTO = [[xxAPIResponse alloc]initWithDictionary:response error:&error];
        xxAPIResponse *customResponse = (xxAPIResponse*)responseDTO;
        success(customResponse);
    }failure:failure];
}

+ (void)rtmStartAPI:(RTMStartRequest*)request success:(void(^)(RTMStartResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self slackShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;
    
    [service GET:[slackBaseURL stringByAppendingString:rtmStart] withParameters:[request toDictionary] success:^(id response){
        responseDTO = [[RTMStartResponse alloc]initWithDictionary:response error:&error];
        RTMStartResponse *customResponse = (RTMStartResponse*)responseDTO;
        success(customResponse);
    }failure:failure];
}

+ (void)getChannelList:(GetChennelListRequest*)request success:(void(^)(GetChennelListResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self slackShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;
    
    [service GET:[slackBaseURL stringByAppendingString:channelList] withParameters:[request toDictionary] success:^(id response){
        responseDTO = [[GetChennelListResponse alloc]initWithDictionary:response error:&error];
        GetChennelListResponse *customResponse = (GetChennelListResponse*)responseDTO;
        success(customResponse);
    }failure:failure];
}







@end
