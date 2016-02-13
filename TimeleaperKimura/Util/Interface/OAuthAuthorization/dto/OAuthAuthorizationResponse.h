//
//  OAuthAuthorizationResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface OAuthAuthorizationResponse : CommonDTO

@property(nonatomic) NSString *access_token;
@property(nonatomic) NSString<Optional>* scope;

@end
