//
//  TimeleaperKimuraService.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonService.h"
#import "CommonWebSocketService.h"

#import "OAuthAuthorizationRequest.h"
#import "OAuthAuthorizationResponse.h"

#import "xxAPIRequest.h"
#import "xxAPIResponse.h"

#import "RTMStartRequest.h"
#import "RTMStartResponse.h"

#import "GetChennelListRequest.h"
#import "GetChennelListResponse.h"

#import "GetUserListRequest.h"
#import "GetUserListResponse.h"

#import "xxAPIMessagesRequest.h"
#import "xxAPIMessagesResponse.h"

#import "xxAPIReplyRequest.h"
#import "xxAPIReplyResponse.h"

@interface TimeleaperKimuraService : CommonService

+ (void)requestOAuthToken:(OAuthAuthorizationRequest*)request success:(void(^)(OAuthAuthorizationResponse*))success failure:(void(^)(NSError *error))failure;

+ (void)postxxAPIMessages:(xxAPIMessagesRequest*)request success:(void(^)(xxAPIMessagesResponse*))success failure:(void(^)(NSError *error))failure;

+ (void)replyxxAPIMessages:(xxAPIReplyRequest*)request success:(void(^)(xxAPIReplyResponse*))success failure:(void(^)(NSError *error))failure;

+ (void)rtmStartAPI:(RTMStartRequest*)request success:(void(^)(RTMStartResponse*))success failure:(void(^)(NSError *error))failure;

+ (void)getChannelList:(GetChennelListRequest*)request success:(void(^)(GetChennelListResponse*))success failure:(void(^)(NSError *error))failure;

+ (void)getUserList:(GetUserListRequest*)request success:(void(^)(GetUserListResponse*))success failure:(void(^)(NSError *error))failure;

/*
+ (void)webSocketStart:(UIViewController*)vc url:(NSString*)url;
+ (void)postMessage:(NSString*)url request:(PostMessageRequest*)request;
*/

@end
