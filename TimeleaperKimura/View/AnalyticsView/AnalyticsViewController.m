//
//  AnalyticsViewController.m
//  TimeleaperKimura
//
//  Created by 岩田彬広 on 2016/02/14.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "AnalyticsViewController.h"

@interface AnalyticsViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;

@end

@implementation AnalyticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //iOS7より、TabBarを設定することによって、変な余白が設定される。(今回の場合、その影響を受けてTabBatの下にToolBarが隠れる)
    //これに対応するため、下記２行を追加
    self.view.translatesAutoresizingMaskIntoConstraints = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //各UIパーツの色を設定
    //NavigationBarのタイトル文字列の色は変更不可なのでUILabelを生成して貼付ける
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.font = [UIFont boldSystemFontOfSize:17.0];
    title.text = @"分析";
    [title sizeToFit];
    self.navigationItem.titleView = title;
    
    self.rightBarButton.target = self;
    self.rightBarButton.action = @selector(dismissView);
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissView {
    [self dismissViewControllerAnimated:YES completion:nil];
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
