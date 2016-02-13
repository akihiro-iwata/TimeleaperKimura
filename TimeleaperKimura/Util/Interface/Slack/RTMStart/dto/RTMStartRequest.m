//
//  RTMStartRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/09.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "RTMStartRequest.h"

@implementation RTMStartRequest

+ (id)request:(NSString*)token simple_latest:(NSString*)simple_latest no_unreads:(NSString*)no_unreads mpim_aware:(NSString*)mpim_aware
{
    return [[self alloc] init:token simple_latest:simple_latest no_unreads:no_unreads mpim_aware:mpim_aware];
}

- (id)init:(NSString*)token simple_latest:(NSString*)simple_latest no_unreads:(NSString*)no_unreads mpim_aware:(NSString*)mpim_aware
{
    self = [self init];
    if(self){
        self.token = token;
        self.simple_latest = simple_latest;
        self.no_unreads = no_unreads;
        self.mpim_aware = mpim_aware;
    }
    return self;
}

@end
