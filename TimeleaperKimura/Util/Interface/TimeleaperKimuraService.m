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

// slack Endpoint
static NSString *postDM = @"api/chat.postMessage";
static NSString *tokenURL = @"api/oauth.access";
static NSString *channelList = @"api/channels.list";
static NSString *userList = @"api/users.list";
static NSString *rtmStart = @"api/rtm.start";
static NSString *groupHistory = @"api/groups.history";

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
/*
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
*/
+ (void)postxxAPIMessages:(xxAPIMessagesRequest*)request success:(void(^)(xxAPIMessagesResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self xxAPIServiceShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;

    [service POST:[xxBaseURL stringByAppendingString:v1Message] withParameters:[request toDictionary] success:^(id response) {
        responseDTO = [[xxAPIMessagesResponse alloc]initWithDictionary:response error:&error];
        xxAPIMessagesResponse *customResponse = (xxAPIMessagesResponse*)responseDTO;
        success(customResponse);
    } failure:failure];
}

+ (void)replyxxAPIMessages:(xxAPIReplyRequest*)request success:(void(^)(xxAPIReplyResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self xxAPIServiceShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;
    
    [service PATCH:[xxBaseURL stringByAppendingString:v1Message] withParameters:[request toDictionary] success:^(id response) {
        responseDTO = [[xxAPIReplyResponse alloc]initWithDictionary:response error:&error];
        xxAPIReplyResponse *customResponse = (xxAPIReplyResponse*)responseDTO;
        success(customResponse);
    } failure:failure];

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

+ (void)getUserList:(GetUserListRequest*)request success:(void(^)(GetUserListResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self slackShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;
    
    [service GET:[slackBaseURL stringByAppendingString:userList] withParameters:[request toDictionary] success:^(id response){
        responseDTO = [[GetUserListResponse alloc]initWithDictionary:response error:&error];
        GetUserListResponse *customResponse = (GetUserListResponse*)responseDTO;
        success(customResponse);
    }failure:failure];
}

+ (void)getGroupHistory:(GetGroupHistoryRequest*)request success:(void(^)(GetGroupHistoryResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self slackShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;
    
    [service GET:[slackBaseURL stringByAppendingString:groupHistory] withParameters:[request toDictionary] success:^(id response){
        responseDTO = [[GetGroupHistoryResponse alloc]initWithDictionary:response error:&error];
        GetGroupHistoryResponse *customResponse = (GetGroupHistoryResponse*)responseDTO;
        success(customResponse);
    }failure:failure];
}

+ (void)postDMRequest:(PostDMRequest*)request success:(void(^)(PostDMResponse*))success failure:(void(^)(NSError *error))failure
{
    CommonService *service = [self slackShared];
    __block CommonDTO *responseDTO;
    __block NSError *error;
    
    [service GET:[slackBaseURL stringByAppendingString:postDM] withParameters:[request toDictionary] success:^(id response){
        responseDTO = [[PostDMResponse alloc]initWithDictionary:response error:&error];
        PostDMResponse *customResponse = (PostDMResponse*)responseDTO;
        success(customResponse);
    }failure:failure];
}
/*
+(void)downloadFileFromURL:(NSString*)url success:(void(^)(NSURL* filePath))success failure:(void(^)(NSString*, NSInteger))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer] ; // 画像を受信する設定
    [manager GET:<あなたの好きなURL>
      parameters:nil
         success:^(AFHTTPRequestOperation *operation,UIImage *image){
             NSLog(@"画像取得成功:%@",image) ;
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             NSLog(@"画像取得失敗") ;
         }] ;
}
*/
@end
