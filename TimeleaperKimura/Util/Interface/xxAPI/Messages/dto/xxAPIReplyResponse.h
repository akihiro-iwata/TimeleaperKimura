//
//  xxAPIReplyResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@protocol Text
@end

@interface Text : CommonDTO
@property(nonatomic) NSString<Optional> *user_id;
@property(nonatomic) NSString<Optional> *partner_id;
@property(nonatomic) NSString<Optional> *ngword;
@property(nonatomic) NSString<Optional> *count_word;
@end

@interface ReplyWords
@property(nonatomic) NSString *ngword;
@property(nonatomic) NSString *response_code;
@end

@interface xxAPIReplyResponse : CommonDTO
/*
@property(nonatomic) ReplyWords<Optional> *words;
@property(nonatomic) NSString *type;
@property(nonatomic) NSString *channel;
@property(nonatomic) NSString *user;
*/
@property(nonatomic) NSArray<Text>* words;

@end
