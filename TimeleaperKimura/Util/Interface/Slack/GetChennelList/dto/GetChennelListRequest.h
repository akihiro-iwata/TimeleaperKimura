//
//  GetChennelListRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface GetChennelListRequest : CommonDTO

@property(nonatomic) NSString *token;
@property(nonatomic) NSString<Optional> *exclude_archived;

+ (id)request:(NSString*)token exclude_archived:(NSString*)exclude_archived;

@end
