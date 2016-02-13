//
//  CommonWebSocketService.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/11.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "SRWebSocket.h"

@interface CommonWebSocketService : SRWebSocket

@property (nonatomic) SRWebSocket *srWebSocket;

// singleton
- (instancetype)initWithBaseURL:(NSURL *)url;

@end
