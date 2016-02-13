//
//  OAuthAuthorizationRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface OAuthAuthorizationRequest : CommonDTO

@property(nonatomic) NSString *client_id;
@property(nonatomic) NSString *client_secret;
@property(nonatomic) NSString *code;
@property(nonatomic) NSString<Optional> *redirect_uri;

+ (id)request:(NSString*)cliend_id client_secret:(NSString*)client_secret redirect_uri:(NSString*)redirect_uri code:(NSString*)code;
@end
