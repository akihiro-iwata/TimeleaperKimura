//
//  xxAPIResponse.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/06.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonDTO.h"
#import "xxAPIRequest.h"

@interface declaredParamsModel : JSONModel
@property (strong, nonatomic) MessageModel* message;
@end

@interface xxAPIResponse : CommonDTO
@property (strong, nonatomic) declaredParamsModel* declared_params;

@end
