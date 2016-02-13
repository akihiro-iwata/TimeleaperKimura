//
//  PostDMResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@protocol Message
@end

@interface Message : CommonDTO
@property(nonatomic) NSString *type;
@property(nonatomic) NSString *user;
@property(nonatomic) NSString *text;
@property(nonatomic) NSString *ts;
@end

@interface PostDMResponse : CommonDTO

@property(nonatomic) NSString *ok;
@property(nonatomic) NSString *channel;
@property(nonatomic) Message *message;

@end
