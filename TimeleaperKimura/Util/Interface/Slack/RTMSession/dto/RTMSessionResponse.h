//
//  RTMSessionResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface Error

@property(nonatomic) NSString *code;
@property(nonatomic) NSString *msg;
@end

@interface RTMSessionResponse : CommonDTO

@property(nonatomic) NSString *type;
@property(nonatomic) Error<Optional> *error;
@property(nonatomic) NSString<Optional> *channel;
@property(nonatomic) NSString<Optional> *user;
@property(nonatomic) NSString<Optional> *text;
@property(nonatomic) NSString<Optional> *ts;

@end
