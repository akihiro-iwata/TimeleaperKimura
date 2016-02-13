//
//  xxAPIReplyRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "xxAPIReplyRequest.h"

@implementation xxAPIReplyRequest

+ (id)request:(NSString*)user_id partner_id:(NSString*)partner_id reply_message:(NSString*)reply_message reply_created_at:(NSString*)reply_created_at;
{
    return [[self alloc]init:user_id partner_id:partner_id reply_message:reply_message reply_created_at:reply_created_at];
}

- (id)init:(NSString*)user_id partner_id:(NSString*)partner_id reply_message:(NSString*)reply_message reply_created_at:(NSString*)reply_created_at
{
    self = [self init];
    if(self){
        self.user_id = user_id;
        self.partner_id = partner_id;
        self.reply_message = reply_message;
        self.reply_created_at = reply_created_at;
    }
    return self;
}

@end
