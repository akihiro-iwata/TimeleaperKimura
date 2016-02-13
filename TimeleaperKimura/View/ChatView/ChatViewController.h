//
//  ChatViewController.h
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import <JSQMessagesViewController/JSQMessages.h>
#import "SRwebSocket.h"
#import "GetUserListResponse.h"

@interface ChatViewController : JSQMessagesViewController<SRWebSocketDelegate>

@property (strong, nonatomic) SRWebSocket *srWebSocket;
@property (strong, nonatomic) Member *Kimura;

@end
