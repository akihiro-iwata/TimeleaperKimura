//
//  AnalyticsViewController.h
//  TimeleaperKimura
//
//  Created by Tomo_N on 2016/02/14.
//  Copyright © 2016年 Akihiro.Iwata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"


@interface AnalyticsViewController : UIViewController<XYPieChartDataSource,XYPieChartDelegate>

// 各スライスの色
@property(nonatomic, strong) NSArray *sliceColors;
// 各スライスのデータ
@property(nonatomic, strong) NSMutableArray *slices;


@end
