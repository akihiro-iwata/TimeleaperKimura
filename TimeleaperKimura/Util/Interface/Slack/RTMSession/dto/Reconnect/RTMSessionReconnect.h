//
//  RTMSessionReconnect.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

//The reconnect_url event is currently unsupported and experimental.
@interface RTMSessionReconnect : CommonDTO

@property(nonatomic) NSString *type;
@property(nonatomic) NSString *url;

@end
