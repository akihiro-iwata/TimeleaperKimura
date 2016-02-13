//
//  GetGroupHistoryResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@protocol Msg
@end

@interface Msg : CommonDTO
@property(nonatomic) NSString *type;
@property(nonatomic) NSString<Optional> *user;
@property(nonatomic) NSString<Optional> *text;
@property(nonatomic) NSString *ts;
@end

@interface GetGroupHistoryResponse : CommonDTO

@property(nonatomic) NSString *ok;
@property(nonatomic) NSString *latest;
@property(nonatomic) NSArray<Msg>* messages;

@end

