//
//  NSObject+RunBlockTasks.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>

@interface NSObject (BlockTasks)

typedef void (^voidBlock)(void);

- (void)dispatch_async_main:(voidBlock)block;
- (void)dispatch_async_global:(voidBlock)block;
/*
- (void)runBlockOnMainThread:(void (^)(void))block;
- (void)runBlockInBackground:(void (^)(void))block;
*/
@end
