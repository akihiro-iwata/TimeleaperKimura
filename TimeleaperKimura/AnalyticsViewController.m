//
//  AnalyticsViewController.m
//  TimeleaperKimura
//
//  Created by Tomo_N on 2016/02/14.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import "AnalyticsViewController.h"

#import "xxAPIReplyResponse.h"


@interface AnalyticsViewController ()


@end

@implementation AnalyticsViewController
{
    xxAPIReplyResponse *response;
    NSArray<Text>* words;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSData *arcData = [ud objectForKey:[self.Kimura.id stringByAppendingString:@"ngwords"]];
        NSData *arcData = [ud objectForKey:@"ngwords"];
    response = [NSKeyedUnarchiver unarchiveObjectWithData:arcData];
    words = response.words;
    
    // スライスに表示するデータの定義
    self.slices = [NSMutableArray arrayWithCapacity:5];
    
    //for (int i = 0; i < 5; i ++) {
    for (int i = 0; i < 5; i ++) {
        //NSNumber *one = [NSNumber numberWithInt:rand() % 60 + 20];
        Text *word = words[i];
        [self.slices addObject:word.count_word];
    }
    
    
    // 各項目の背景色を定義
    self.sliceColors = @[[UIColor colorWithRed:246/255.0 green:155/255.0 blue:0/255.0 alpha:1],
                         [UIColor colorWithRed:129/255.0 green:195/255.0 blue:29/255.0 alpha:1],
                         [UIColor colorWithRed:62/255.0 green:173/255.0 blue:219/255.0 alpha:1],
                         [UIColor colorWithRed:229/255.0 green:66/255.0 blue:115/255.0 alpha:1],
                         [UIColor colorWithRed:148/255.0 green:141/255.0 blue:139/255.0 alpha:1]];
    
    // パイチャートの初期化
    XYPieChart *pieChart = [[XYPieChart alloc] initWithFrame:CGRectMake(10, 10, 220.0, 220.0)];
    
    // デリゲートの設定
    pieChart.delegate = self;
    // データソースの設定
    pieChart.dataSource = self;
    // パイチャートの中心位置
    pieChart.pieCenter = self.view.center;
    // YESの場合、パーセンテージで数字を表示します。
    pieChart.showPercentage = NO;
    // 値を表示するラベルのフォント
    pieChart.labelFont = [UIFont systemFontOfSize:12.0];
    // 値を表示するラベルの色
    pieChart.labelColor = [UIColor blackColor];
    // 値を表示するラベル背景のシャドウカラー
    pieChart.labelShadowColor = [UIColor darkGrayColor];
    // 表示アニメーションのスピード
    pieChart.animationSpeed = 1.0;
    // パイチャートの背景色
    [pieChart setPieBackgroundColor:[UIColor darkGrayColor]];
    
    [self.view addSubview:pieChart];
    
    // パイチャートを描画します。
    [pieChart reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// スライスの件数
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    //return response.text.count;
    return self.slices.count;
}

// 各スライスの値
- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [self.slices[index] floatValue];
    //Text *text = response.text[index];
    //NSNumber *num = [NSNumber numberWithInt:[text.count_word intValue]];
    //return [num floatValue];
}

// 各スライスの色を設定(Optional)
- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return self.sliceColors[(index % self.sliceColors.count)];
}

// 各スライスに表示する文字列の設定(Optional)
- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index
{
    //return [NSString stringWithFormat:@"%@ 件",]
    Text *str = words[index];
    return [NSString stringWithFormat:[str.ngword stringByAppendingString:@"\n"], self.slices[index]];
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
