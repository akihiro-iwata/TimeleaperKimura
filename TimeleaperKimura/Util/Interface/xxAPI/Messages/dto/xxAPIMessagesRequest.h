//
//  xxAPIMessagesRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface xxAPIMessagesRequest : CommonDTO

//application/json
@property(nonatomic) NSString *user_id;
@property(nonatomic) NSString *partner_id;
@property(nonatomic) NSString *send_message;
@property(nonatomic) NSString *send_created_at; //yyyy-mm-dd hh24:mm:ss
/*
@property(nonatomic) NSString *reply_message;
@property(nonatomic) NSString *reply_created_at; //yyyy-mm-dd hh24:mm:ss
*/
+ (id)request:(NSString*)user_id partner_id:(NSString*)partner_id send_message:(NSString*)send_message send_created_at:(NSString*)send_created_at;

@end
