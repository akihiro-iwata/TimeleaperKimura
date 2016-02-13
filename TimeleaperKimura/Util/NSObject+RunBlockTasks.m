//
//  NSObject+RunBlockTasks.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "NSObject+RunBlockTasks.h"

@implementation NSObject (BlockTasks)

- (void) dispatch_async_main:(voidBlock)block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

- (void) dispatch_async_global:(voidBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
/*
- (void)runBlockOnMainThread:(void (^)(void))block
{
    if([NSThread currentThread].isMainThread){
        block();
    }else{
        dispatch_queue_t queue = dispatch_get_main_queue();
        dispatch_sync(queue, block);
    }
}

- (void)runBlockInBackground:(void (^)(void))block
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, block);
}
*/
@end
