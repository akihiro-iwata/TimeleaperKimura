//
//  OAuthAuthorizationRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "OAuthAuthorizationRequest.h"

@implementation OAuthAuthorizationRequest

+ (id)request:(NSString*)cliend_id client_secret:(NSString*)client_secret redirect_uri:(NSString*)redirect_uri code:(NSString*)code
{
    return [[self alloc] init:cliend_id client_secret:client_secret redirect_uri:redirect_uri code:code];
}

- (id)init:(NSString*)cliend_id client_secret:(NSString*)client_secret redirect_uri:(NSString*)redirect_uri code:(NSString*)code
{
    self = [self init];
    if(self){
        self.client_id = cliend_id;
        self.client_secret = client_secret;
        self.code = code;
        self.redirect_uri = redirect_uri;
    }
    return self;
}

@end
