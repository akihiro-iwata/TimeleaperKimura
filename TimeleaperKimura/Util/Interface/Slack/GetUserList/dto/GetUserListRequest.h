//
//  GetUserListRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface GetUserListRequest : CommonDTO

@property(nonatomic) NSString *token;
@property(nonatomic) NSString<Optional> *presence;

+ (id)request:(NSString*)token presence:(NSString*)presence;
@end
