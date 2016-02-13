//
//  PostDMRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "PostDMRequest.h"

@implementation PostDMRequest

+ (id)request:(NSString*)token channel:(NSString*)channel text:(NSString*)text username:(NSString*)username  as_user:(NSString*)as_user
{
    return [[self alloc]init:token channel:channel text:text username:username as_user:as_user];
}

- (id)init:(NSString*)token channel:(NSString*)channel text:(NSString*)text username:(NSString*)username as_user:(NSString*)as_user
{
    self = [self init];
    if(self){
        self.token = token;
        self.channel = channel;
        self.text = text;
        self.username = username;
        self.as_user = as_user;
    }
    return self;
}



@end
