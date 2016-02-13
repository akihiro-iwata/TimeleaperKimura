//
//  xxAPIReplyResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface ReplyWords
@property(nonatomic) NSString *ngword;
@property(nonatomic) NSString *response_code;
@end

@interface xxAPIReplyResponse : CommonDTO

@property(nonatomic) ReplyWords *words;

@end
