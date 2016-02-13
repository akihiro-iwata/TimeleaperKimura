//
//  GetChennelListResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface purpose
@property(nonatomic) NSString *value;
@property(nonatomic) NSString *creator;
@property(nonatomic) NSString *last_set;
@end

@interface topic
@property(nonatomic) NSString *value;
@property(nonatomic) NSString *creator;
@property(nonatomic) NSString *last_set;
@end

@interface channel
@property(nonatomic) NSString *id;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *created;
@property(nonatomic) NSString *creator;
@property(nonatomic) NSString *is_archived;
@property(nonatomic) NSString *is_member;
@property(nonatomic) NSString *num_members;
@property(nonatomic) topic *topic;
@property(nonatomic) purpose *purpose;
@end

@interface GetChennelListResponse : CommonDTO

@property(nonatomic) NSString *ok;
@property(nonatomic) NSArray<channel*><Optional> *channels;

@end
