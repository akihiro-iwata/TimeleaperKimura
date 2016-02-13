//
//  ChatViewController.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "ChatViewController.h"

#import "NSObject+RunBlockTasks.h"

#import "TimeleaperKimuraService.h"
#import "xxAPIMessagesRequest.h"
#import "xxAPIMessagesResponse.h"

#import "RTMSessionRequest.h"
#import "RTMSessionResponse.h"

#import "PostMessageRequest.h"

#import "GetUserListResponse.h"

#import "SVProgressHUD.h"
#import "NSObject+RunBlockTasks.h"

@interface ChatViewController ()

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) JSQMessagesBubbleImage *incomingBubble;
@property (strong, nonatomic) JSQMessagesBubbleImage *outgoingBubble;
@property (strong, nonatomic) JSQMessagesAvatarImage *incomingAvatar;
@property (strong, nonatomic) JSQMessagesAvatarImage *outgoingAvatar;
@end

@implementation ChatViewController
{
    Member *myList;
    // チャット相手
    //Member *Kimura;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSData *myData = [ud objectForKey:@"myList"];
    myList = [NSKeyedUnarchiver unarchiveObjectWithData:myData];
    
    // ① 自分の senderId, senderDisplayName を設定
    self.senderId = myList.id;
    self.senderDisplayName = myList.name;
    
    // ② MessageBubble (背景の吹き出し) を設定
    JSQMessagesBubbleImageFactory *bubbleFactory = [JSQMessagesBubbleImageFactory new];
    self.incomingBubble = [bubbleFactory  incomingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleLightGrayColor]];
    self.outgoingBubble = [bubbleFactory  outgoingMessagesBubbleImageWithColor:[UIColor jsq_messageBubbleGreenColor]];
    
    // ③ アバター画像を設定
    self.incomingAvatar = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"User2"] diameter:64];
    self.outgoingAvatar = [JSQMessagesAvatarImageFactory avatarImageWithImage:[UIImage imageNamed:@"User1"] diameter:64];
    
    // ④ メッセージデータの配列を初期化
    self.messages = [NSMutableArray array];
    
    // rtm session start
    [SVProgressHUD showWithStatus:@"now loading..."];
    [self startRTMSession];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.srWebSocket close];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JSQMessagesViewController

// ⑤ Sendボタンが押下されたときに呼ばれる
- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    // NG word validation
    [self validationMessage:button withMessageText:text senderId:senderId senderDisplayName:senderDisplayName date:date];
}

#pragma mark - JSQMessagesCollectionViewDataSource

// ④ アイテムごとに参照するメッセージデータを返す
- (id<JSQMessageData>)collectionView:(JSQMessagesCollectionView *)collectionView messageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.messages objectAtIndex:indexPath.item];
}

// ② アイテムごとの MessageBubble (背景) を返す
- (id<JSQMessageBubbleImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView messageBubbleImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.outgoingBubble;
    }
    return self.incomingBubble;
}

// ③ アイテムごとのアバター画像を返す
- (id<JSQMessageAvatarImageDataSource>)collectionView:(JSQMessagesCollectionView *)collectionView avatarImageDataForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JSQMessage *message = [self.messages objectAtIndex:indexPath.item];
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.outgoingAvatar;
    }
    return self.incomingAvatar;
}

#pragma mark - UICollectionViewDataSource

// ④ アイテムの総数を返す
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark - Auto Message

// ⑥ 返信メッセージを受信する (自動)
- (void)receiveAutoMessage
{
    // 1秒後にメッセージを受信する
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(didFinishMessageTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)didFinishMessageTimer:(NSTimer*)timer
{
    // 効果音を再生する
    [JSQSystemSoundPlayer jsq_playMessageSentSound];
    // 新しいメッセージデータを追加する
    JSQMessage *message = [JSQMessage messageWithSenderId:@"user2"
                                              displayName:@"underscore"
                                                     text:@"Hello"];
    [self.messages addObject:message];
    // メッセージの受信処理を完了する (画面上にメッセージが表示される)
    [self finishReceivingMessageAnimated:YES];
}

#pragma mark -
#pragma mark IF Operations
- (void)validationMessage:(UIButton *)button
    withMessageText:(NSString *)text
           senderId:(NSString *)senderId
  senderDisplayName:(NSString *)senderDisplayName
               date:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];

    __block xxAPIMessagesRequest *request = [xxAPIMessagesRequest request:myList.id partner_id:self.Kimura.id send_message:text send_created_at:dateStr];
    
    __block __weak ChatViewController *blockSelf = self;
    
    NSString *word = @"次のメッセージはNGワードです!!\n";
    
    [self dispatch_async_global:^{
        [TimeleaperKimuraService postxxAPIMessages:request success:^(xxAPIMessagesResponse *response) {
            NSLog(@"validation result: %@",response);
            
            [blockSelf dispatch_async_main:^{

                // ngワードがあったら送信を中止する
                Words *ng = response.words[0];
                if(ng.ngword){
                    NSString *NGWord = [word stringByAppendingString:ng.ngword];
                    //[SVProgressHUD dismiss];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"NGワード" message:NGWord preferredStyle:UIAlertControllerStyleAlert];
                    
                    [alert addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    }]];
                    [self presentViewController:alert animated:true completion:nil];
                    
                }else{
                    // 効果音を再生する
                    [JSQSystemSoundPlayer jsq_playMessageSentSound];
                    // 新しいメッセージデータを追加する
                    JSQMessage *message = [JSQMessage messageWithSenderId:senderId
                                                              displayName:senderDisplayName
                                                                     text:text];
                    [blockSelf.messages addObject:message];
                    [blockSelf postMeesage:button withMessageText:text senderId:senderId senderDisplayName:senderDisplayName date:date];
                }
                
            }];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }];
}

- (void)postMeesage:(UIButton *)button
    withMessageText:(NSString *)text
           senderId:(NSString *)senderId
  senderDisplayName:(NSString *)senderDisplayName
               date:(NSDate *)date {
    
//    NSString *request = [[PostMessageRequest request:myList.id type:@"message" channel:@"C0KTT7JLE" text:text] toJSONString];
    NSString *request = [[PostMessageRequest request:myList.id type:@"message" channel:[@"@" stringByAppendingString:self.Kimura.name] text:text] toJSONString];
    NSLog(@"%@",request);
    NSLog(@"%@",[@"@" stringByAppendingString:self.Kimura.name]);
    
    [self.srWebSocket send:request];
    
    // メッセージの送信処理を完了する (画面上にメッセージが表示される)
    [self finishSendingMessageAnimated:YES];
}

#pragma mark -
#pragma mark Slack Real Time Message
- (void)startRTMSession {
 
     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
 
     __block RTMStartRequest *request = [RTMStartRequest request:[ud stringForKey:@"access_token"] simple_latest:nil no_unreads:nil mpim_aware:nil];
 
     __block ChatViewController *blockSelf = self;
 
     [self dispatch_async_global:^{
        [TimeleaperKimuraService rtmStartAPI:request success:^(RTMStartResponse *response) {
            [ud setObject:response.url forKey:@"rtm_url"];
            [ud synchronize];
            [self dispatch_async_main:^{
                //start websocket sessionq
                SRWebSocket *web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[ud stringForKey:@"rtm_url"]]]];
                [web_socket setDelegate:blockSelf];
                [web_socket open];
            }];
 
        } failure:^(NSError *error) {
            [self dispatch_async_main:^{
                NSLog(@"%@",error);
                [SVProgressHUD showErrorWithStatus:@"failed"];
            }];
        }];
     }];
}

#pragma mark -
#pragma mark WebSocket Delegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    [SVProgressHUD dismiss];
    
    self.srWebSocket = webSocket;
    NSLog(@"websocket did open:%@",webSocket);
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"didReceiveMessage: %@", [message description]);
    
    xxAPIReplyRequest *request = [xxAPIReplyRequest request:myList.id partner_id:self.Kimura.id reply_message:@"嫌い" reply_created_at:@"2016-02-13 18:00:00"];
    
    [TimeleaperKimuraService replyxxAPIMessages:request success:^(xxAPIReplyResponse *response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
