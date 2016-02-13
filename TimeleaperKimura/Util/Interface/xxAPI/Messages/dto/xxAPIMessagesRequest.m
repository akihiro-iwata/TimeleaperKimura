//
//  xxAPIMessagesRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "xxAPIMessagesRequest.h"

@implementation xxAPIMessagesRequest

+ (id)request:(NSString*)user_id partner_id:(NSString*)partner_id send_message:(NSString*)send_message send_created_at:(NSString*)send_created_at;
{
    return [[self alloc]init:user_id partner_id:partner_id send_message:send_message send_created_at:send_created_at];
}

- (id)init:(NSString*)user_id partner_id:(NSString*)partner_id send_message:(NSString*)send_message send_created_at:(NSString*)send_created_at
{
    self = [self init];
    if(self){
        self.user_id = user_id;
        self.partner_id = partner_id;
        self.send_message = send_message;
        self.send_created_at = send_created_at;
    }
    return self;
}

@end
