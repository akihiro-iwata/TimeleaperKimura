//
//  CommonService.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "AFNetworkActivityIndicatorManager.h"
#import "AFHTTPSessionManager.h"

@interface CommonService : AFHTTPSessionManager

@property (nonatomic) AFHTTPSessionManager *sessionManager;

// singleton
- (instancetype)initWithBaseURL:(NSURL *)url;

// request
- (void)GET:(NSString*)relativePath withParameters:(NSDictionary*)parameters success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

- (void)POST:(NSString*)relativePath withParameters:(NSDictionary*)parameters success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;



@end
