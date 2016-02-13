//
//  xxAPIRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/06.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "xxAPIRequest.h"

@implementation MessageModel
@end

@implementation xxAPIRequest

+ (id)request:(NSString*)user_id message:(NSString*)message
{
    return [[self alloc]init:user_id message:message];
}

- (id)init:(NSString*)user_id message:(NSString*)message
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    
    self = [self init];
    if(self){
        self.user_id = user_id;
        self.message = message;
        self.created_at = dateStr;
        self.updated_at = dateStr;
    }
    return self;
}

@end

