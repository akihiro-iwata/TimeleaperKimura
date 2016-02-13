//
//  GetUserListRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "GetUserListRequest.h"

@implementation GetUserListRequest

+ (id)request:(NSString*)token presence:(NSString*)presence
{
    return [[self alloc]init:token presence:presence];
}

- (id)init:(NSString*)token presence:(NSString*)presence
{
    self = [self init];
    if(self){
        self.token = token;
        self.presence = presence;
    }
    return self;
}

@end
