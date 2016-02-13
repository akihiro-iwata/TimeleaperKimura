//
//  AppDelegate.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/02.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "AppDelegate.h"
#import "NXOAuth2.h"
#import "PassConst.h"

#import "NSURL+dictionaryFromQueryString.h"
#import "TimeleaperKimuraService.h"
#import "ViewController.h"

static NSString const * urlScheme = @"timeleaperkimura";

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize;
{
    [[NXOAuth2AccountStore sharedStore] setClientID:kOauth2ClientClientId
                                             secret:kOauth2ClientClientId
                                              scope:[NSSet setWithObjects:scope, nil]
                                   authorizationURL:[NSURL URLWithString:auth_url]
                                           tokenURL:[NSURL URLWithString:token_url]
                                        redirectURL:[NSURL URLWithString:redirect_uri]
                                      keyChainGroup:@"hoge"
                                          tokenType:@"access_token"
                                     forAccountType:accountType];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //NSLog(@"url = %@",url);
    NSDictionary *dict = [url dictionaryFromQueryString];
    
    // set code to userdefaults
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:dict[@"code"] forKey:@"code"];
    
    // get token
    [TimeleaperKimuraService requestOAuthToken:[OAuthAuthorizationRequest request:kOauth2ClientClientId client_secret:kOauth2ClientClientSecret redirect_uri:redirect_uri code:[ud stringForKey:@"code"]] success:^(OAuthAuthorizationResponse *response) {
        
        [ud setBool:YES forKey:@"HasLaunchedOnce"];
        [ud setObject:response.access_token forKey:@"access_token"];
        [ud synchronize];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
        
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /*
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UIViewController *rootVC = [[ViewController alloc]init];
    self.naviController = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = self.naviController;
    self.window.backgroundColor = [UIColor whiteColor]; // #ffffff

    [self.window makeKeyAndVisible];
    */
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
