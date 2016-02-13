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

#import "PostDMRequest.h"
#import "PostDMResponse.h"

#import "GetGroupHistoryRequest.h"
#import "GetGroupHistoryResponse.h"
//#import "PostMessageRequest.h"

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
    NSUserDefaults *ud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //iOS7より、TabBarを設定することによって、変な余白が設定される。(今回の場合、その影響を受けてTabBatの下にToolBarが隠れる)
    //これに対応するため、下記２行を追加
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //各UIパーツの色を設定
    //NavigationBarのタイトル文字列の色は変更不可なのでUILabelを生成して貼付ける
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.font = [UIFont boldSystemFontOfSize:17.0];
    title.text = self.Kimura.name;
    [title sizeToFit];
    self.navigationItem.titleView = title;
    
    ud = [NSUserDefaults standardUserDefaults];
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
    
    NSData *chatArchiveData = [ud objectForKey:self.Kimura.id];
    NSMutableArray *chatArchveArray = [[NSMutableArray alloc]init];
    chatArchveArray = [NSKeyedUnarchiver unarchiveObjectWithData:chatArchiveData];
    
    // rtm session start
    [SVProgressHUD showWithStatus:@"now loading..."];
    [self getGroupHistory];
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
    [SVProgressHUD showWithStatus:@"now loading..."];
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

#pragma mark -
#pragma mark IF Operations
- (void)getGroupHistory {
        
    __block GetGroupHistoryRequest *request = [GetGroupHistoryRequest request:[ud stringForKey:@"access_token"] channel:@"D0KTUL8F8"];
    
    __block ChatViewController *blockSelf = self;
    
    [self dispatch_async_global:^{
        [TimeleaperKimuraService getGroupHistory:request success:^(GetGroupHistoryResponse *response) {
            NSLog(@"%@",response);
            [blockSelf startRTMSession];
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }];
}


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
                    [SVProgressHUD dismiss];
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
    
    PostDMRequest *request = [PostDMRequest request:[ud stringForKey:@"access_token"] channel:[@"@" stringByAppendingString:self.Kimura.name] text:text username:myList.name as_user:myList.name];
    
    __block __weak ChatViewController *blockSelf = self;
    
    [TimeleaperKimuraService postDMRequest:request success:^(PostDMResponse *response) {
        NSLog(@"private channel: %@",response.channel);
        [blockSelf dispatch_async_main:^{
            [SVProgressHUD dismiss];

            // メッセージの送信処理を完了する (画面上にメッセージが表示される)
            [blockSelf finishSendingMessageAnimated:YES];
        }];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",error);
    }];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.messages];
    [ud setObject:data forKey:self.Kimura.id];
    [ud synchronize];
    //[self.srWebSocket send:request];
}

#pragma mark -
#pragma mark Slack Real Time Message
- (void)startRTMSession {
 
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
    
    // message receive
    NSError *error = nil;
    RTMSessionResponse *response = [[RTMSessionResponse alloc]initWithString:[message description] error:&error];
    
    __block __weak ChatViewController *blockSelf = self;
    
    if(!error && [response.user isEqualToString:self.Kimura.id] ){

        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        /* 24時間表記 */
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSString *date24 = [dateFormatter stringFromDate:date];
        
        xxAPIReplyRequest *request = [xxAPIReplyRequest request:myList.id partner_id:self.Kimura.id reply_message:response.text reply_created_at:date24];
        
        [TimeleaperKimuraService replyxxAPIMessages:request success:^(xxAPIReplyResponse *NGresponse) {
            NSLog(@"%@",NGresponse);
            
            [blockSelf dispatch_async_main:^{
                // 効果音を再生する
                [JSQSystemSoundPlayer jsq_playMessageSentSound];
                // 新しいメッセージデータを追加する
                JSQMessage *message = [JSQMessage messageWithSenderId:blockSelf.Kimura.id
                                                          displayName:blockSelf.Kimura.name
                                                                 text:response.text];
                [blockSelf.messages addObject:message];
                // メッセージの受信処理を完了する (画面上にメッセージが表示される)
                [blockSelf finishReceivingMessageAnimated:YES];
                /*
                NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
                [ud setObject:blockSelf.messages forKey:blockSelf.Kimura.id];
                [ud synchronize];
                 */
            }];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.messages];
    [ud setObject:data forKey:self.Kimura.id];
    [ud synchronize];
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
