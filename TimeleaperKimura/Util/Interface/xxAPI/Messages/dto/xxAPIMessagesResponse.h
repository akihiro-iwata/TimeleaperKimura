//
//  xxAPIMessagesResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface Words : CommonDTO
@property(nonatomic) NSString<Optional> *ngword;
@property(nonatomic) NSString *response_code;
@end

@protocol Words
@end

@interface xxAPIMessagesResponse : CommonDTO

@property(nonatomic) NSArray<Words>* words;

@end
