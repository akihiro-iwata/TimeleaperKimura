//
//  MemberViewController.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/13.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberViewTableViewCell.h"

#import "ChatViewController.h"

#import "TimeleaperKimuraService.h"
#import "RTMSessionRequest.h"
#import "RTMSessionResponse.h"

#import "xxAPIMessagesRequest.h"
#import "xxAPIMessagesResponse.h"

#import "SVProgressHUD.h"
#import "NSObject+RunBlockTasks.h"

@interface MemberViewController ()

@property (weak, nonatomic) IBOutlet UITableView *memberList;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end

@implementation MemberViewController
{
    // member info
    NSMutableArray *memberArray;
    //SRWebSocket *srwebSocket;
    Member *Kimura;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // get User List
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud synchronize];
    memberArray = [[NSMutableArray alloc]init];
    
    //[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSData *obj1 = [ud objectForKey:@"userList"];
    memberArray = [NSKeyedUnarchiver unarchiveObjectWithData:obj1];
    
    // register cell nib
    UINib *cellNib = [UINib nibWithNibName:@"MemberViewTableViewCell" bundle:nil];
    [self.memberList registerNib:cellNib forCellReuseIdentifier:@"MemberViewTableViewCell"];
    
    // rtm session start
    // [SVProgressHUD showWithStatus:@"now loading..."];
    // [self startRTMSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Slack Real Time Message
/*
- (void)startRTMSession {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    __block RTMStartRequest *request = [RTMStartRequest request:[ud stringForKey:@"access_token"] simple_latest:nil no_unreads:nil mpim_aware:nil];
    
    __block MemberViewController *blockSelf = self;
    
    [self dispatch_async_global:^{
        [TimeleaperKimuraService rtmStartAPI:request success:^(RTMStartResponse *response) {
            [ud setObject:response.url forKey:@"rtm_url"];
            [ud synchronize];
            [self dispatch_async_main:^{
                [SVProgressHUD dismiss];
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
 */
/*
#pragma mark -
#pragma mark WebSocket Delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"websocket did open:%@",webSocket);
    srwebSocket = webSocket;
    
     NSString *request = [[PostMessageRequest request:@"1" type:@"message" channel:@"C0KTT7JLE" text:@"This is test message"] toJSONString];
     NSLog(@"%@",request);
     
     [webSocket send:request];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"didReceiveMessage: %@", [message description]);
}
*/

#pragma mark -
#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"gotoChatView"]) {
        ChatViewController *controller = segue.destinationViewController;
        controller.Kimura = Kimura;
        //[srwebSocket setDelegate:controller];
        ///controller.srWebSocket = srwebSocket;
    }
}


#pragma mark -
#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Kimura = memberArray[indexPath.row + 1];
    [self performSegueWithIdentifier:@"gotoChatView" sender:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberViewTableViewCell *cell = [self.memberList dequeueReusableCellWithIdentifier:@"MemberViewTableViewCell"];
    
    if(!cell){
        cell = [[MemberViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MemberViewTableViewCell"];
    }
    [cell setData:memberArray[indexPath.row + 1]];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [memberArray count] - 1;
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
