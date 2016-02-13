//
//  NSObject+RunBlockBackGround.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/05.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "NSObject+RunBlockBackGround.h"

@implementation NSObject (RunBlockBackGround)

- (void)runBlockInBackground:(void (^)(void))block
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);    
}

@end
