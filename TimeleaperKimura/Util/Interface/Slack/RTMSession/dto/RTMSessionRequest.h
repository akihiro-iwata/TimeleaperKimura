//
//  RTMSessionRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface RTMSessionRequest : CommonDTO

@property(nonatomic) NSString *id;
@property(nonatomic) NSString *type;
@property(nonatomic) NSString *channel;
@property(nonatomic) NSString *text;

@end
