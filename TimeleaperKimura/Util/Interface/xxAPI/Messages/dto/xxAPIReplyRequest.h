//
//  xxAPIReplyRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface xxAPIReplyRequest : CommonDTO

//application/json
@property(nonatomic) NSString *user_id;
@property(nonatomic) NSString *partner_id;
@property(nonatomic) NSString *reply_message;
@property(nonatomic) NSString *reply_created_at; //yyyy-mm-dd hh24:mm:ss

+ (id)request:(NSString*)user_id partner_id:(NSString*)partner_id reply_message:(NSString*)reply_message reply_created_at:(NSString*)reply_created_at;

@end
