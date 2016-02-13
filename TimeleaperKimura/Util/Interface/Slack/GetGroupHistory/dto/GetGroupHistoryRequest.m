//
//  GetGroupHistoryRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "GetGroupHistoryRequest.h"

@implementation GetGroupHistoryRequest

+ (id)request:(NSString*)token channel:(NSString*)channel
{
    return [[self alloc]init:token channel:channel];
}

- (id)init:(NSString*)token channel:(NSString*)channel
{
    self = [self init];
    if(self){
        self.token = token;
        self.channel = channel;
    }
    return self;
}

@end
