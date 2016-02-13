//
//  GetChennelListRequest.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "GetChennelListRequest.h"

@implementation GetChennelListRequest

+ (id)request:(NSString*)token exclude_archived:(NSString*)exclude_archived
{
    return [[self alloc]init:token exclude_archived:exclude_archived];
}

- (id)init:(NSString*)token exclude_archived:(NSString*)exclude_archived
{
    self = [self init];
    if(self){
        self.token = token;
        self.exclude_archived = exclude_archived;
    }
    return self;
}

@end
