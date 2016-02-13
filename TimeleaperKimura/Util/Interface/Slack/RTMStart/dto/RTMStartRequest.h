//
//  RTMStartRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/09.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface RTMStartRequest : CommonDTO

@property(nonatomic) NSString *token;
@property(nonatomic) NSString<Optional> *simple_latest;
@property(nonatomic) NSString<Optional> *no_unreads;
@property(nonatomic) NSString<Optional> *mpim_aware;

+ (id)request:(NSString*)token simple_latest:(NSString*)simple_latest no_unreads:(NSString*)no_unreads mpim_aware:(NSString*)mpim_aware;
@end
