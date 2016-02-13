//
//  MemberViewTableViewCell.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetChennelListResponse.h"


@interface MemberViewTableViewCell : UITableViewCell

- (void)setData:(GetChennelListResponse*)info;
@end
