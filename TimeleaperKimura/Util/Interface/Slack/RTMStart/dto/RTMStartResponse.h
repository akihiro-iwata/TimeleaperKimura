//
//  RTMStartResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/10.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface team : NSObject

@end

@interface RTMStartResponse : CommonDTO

@property(nonatomic) NSString *ok;
@property(nonatomic) NSString<Optional> *url;

@end
