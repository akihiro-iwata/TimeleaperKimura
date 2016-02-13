//
//  GetUserListResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface Profile
@property(nonatomic) NSString *first_name;
@property(nonatomic) NSString *last_name;
@property(nonatomic) NSString *real_name;
@property(nonatomic) NSString *email;
@property(nonatomic) NSString<Optional> *skype;
@property(nonatomic) NSString<Optional> *phone;
@property(nonatomic) NSString<Optional> *image_24;
@property(nonatomic) NSString<Optional> *image_32;
@property(nonatomic) NSString<Optional> *image_48;
@property(nonatomic) NSString<Optional> *image_72;
@property(nonatomic) NSString *image_192;
@end

@protocol Member
@end

@interface Member : CommonDTO
@property(nonatomic) NSString *id;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *deleted;
@property(nonatomic) NSString *color;
@property(nonatomic) Profile *profile;
@property(nonatomic) NSString<Optional> *is_admin;
@property(nonatomic) NSString<Optional> *is_owner;
@property(nonatomic) NSString<Optional> *has_2fa;
@property(nonatomic) NSString<Optional> *has_files;
@end

@interface GetUserListResponse : CommonDTO

@property(nonatomic) NSString *ok;
@property(nonatomic) NSArray<Member>* members;

@end
