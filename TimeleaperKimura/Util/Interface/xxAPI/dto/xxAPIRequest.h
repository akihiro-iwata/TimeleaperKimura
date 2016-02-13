//
//  xxAPIRequest.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/06.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"

@interface MessageModel : JSONModel
@end

@interface xxAPIRequest : CommonDTO
@property (strong, nonatomic) NSString* user_id;
@property (strong, nonatomic) NSString* message;
@property (strong, nonatomic) NSString* created_at;
@property (strong, nonatomic) NSString* updated_at;

+ (id)request:(NSString*)user_id message:(NSString*)message;

@end
