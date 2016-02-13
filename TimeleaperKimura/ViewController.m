//
//  ViewController.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/02.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "ViewController.h"
#import "TimeleaperKimuraService.h"

#import "xxAPIRequest.h"
#import "xxAPIResponse.h"

#import "GetChennelListRequest.h"
#import "GetChennelListResponse.h"

#import "NXOAuth2.h"
#import "PassConst.h"

#import "RTMSessionReconnect.h"

@interface ViewController ()

// Set this before opening
@property (nonatomic, assign) id <SRWebSocketDelegate> delegate;
@end

@implementation ViewController

- (IBAction)startApp:(id)sender {
    
    [self getOAuthAuthorization];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)viewWillAppear:(BOOL)animated{
    // get Access token (and Access code)
    //[self getOAuthAuthorization];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark IF Operations
- (void)getOAuthAuthorization {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (![ud boolForKey:@"HasLaunchedOnce"]){
        // process if this is first time to launch this app
        [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType:accountType];
    }else{
        [self getChannelList];
    }
     
}

- (void)getChannelList {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    __block __weak ViewController *blockSelf = self;
    __block GetChennelListRequest *request = [GetChennelListRequest request:[ud stringForKey:@"access_token"] exclude_archived:@"1"];
    
    [TimeleaperKimuraService getChannelList:request success:^(GetChennelListResponse *response) {
        
        // save channel list
        NSLog(@"%@",response);
        [ud setObject:response.channels forKey:@"channelList"];
        [ud synchronize];
        
        [blockSelf getRTMUrl];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)getRTMUrl {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    __block RTMStartRequest *request = [RTMStartRequest request:[ud stringForKey:@"access_token"] simple_latest:nil no_unreads:nil mpim_aware:nil] ;
    
    [TimeleaperKimuraService rtmStartAPI:request success:^(RTMStartResponse *response) {
        [ud setObject:response.url forKey:@"rtm_url"];
        [ud synchronize];
 
        //start websocket sessionq
        SRWebSocket *web_socket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[ud stringForKey:@"rtm_url"]]]];
        [web_socket setDelegate:self];
        [web_socket open];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 
#pragma mark WebSocket Delegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    NSLog(@"websocket did open:%@",webSocket);
    
    NSString *request = [[PostMessageRequest request:@"1" type:@"message" channel:@"C0KTT7JLE" text:@"This is test message"] toJSONString];
    NSLog(@"%@",request);
    
    [webSocket send:request];

}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSLog(@"didReceiveMessage: %@", [message description]);

}





@end
