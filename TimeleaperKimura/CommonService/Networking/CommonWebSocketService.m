//
//  CommonWebSocketService.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "CommonWebSocketService.h"

@implementation CommonWebSocketService

// 引数のprotocol適用確認どうやるんだっけ…
- (instancetype)initWithBaseURL:(NSURL *)url {
    
    if ((self.srWebSocket = [super initWithURL:url])){
        // configuration
    }
    
    return self;
}


@end
