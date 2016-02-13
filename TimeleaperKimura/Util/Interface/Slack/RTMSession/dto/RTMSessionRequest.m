//
//  RTMSessionRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "RTMSessionRequest.h"

@implementation RTMSessionRequest

+ (id)request:(NSString*)id type:(NSString*)type channel:(NSString*)channel text:(NSString*)text
{
    return [[self alloc]init:id type:type channel:channel text:text];
}

- (id)init:(NSString*)id type:(NSString*)type channel:(NSString*)channel text:(NSString*)text
{
    self = [self init];
    if(self){
        self.id = id;
        self.type = type;
        self.channel = channel;
        self.text = text;
    }
    return self;
}

@end
