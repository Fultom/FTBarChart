//
//  FTBarChartViewController.m
//  FTBarChart
//
//  Created by 徐法同 on 16/7/26.
//  Copyright © 2016年 徐法同. All rights reserved.
//

#import "FTBarChartViewController.h"
#import "FTBarChart.h"
@interface FTBarChartViewController ()
@property (nonatomic, strong) NSArray *dataSourceArr;
@end

@implementation FTBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    FTBarChart  *barchart = [[FTBarChart alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width *3/4.0) theMostValue:600 dateSource:nil]; //在这里直接给出数据源数组也可
    
    //柱子高度比例
    barchart.dataSourceArr = @[@[@0.2,@0.8],@[@0.7,@0.9],@[@0.4,@0.8],@[@0.2,@0.8],@[@0.5,@0.8],@[@0.6,@0.8],];
    //下方文字
    barchart.TextArray = @[@"统计1",@"统计2",@"统计3",@"统计4",@"统计5",@"统计6"];
    
    //每条柱子的货物具体数量
    barchart.NumberArray = @[@[@566,@978],@[@456,@854],@[@566,@978],@[@566,@978],@[@566,@978],@[@456,@854]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:barchart];
    
    
    
    /**-------------------下方代码不会影响柱形图的显示效果--------------------*/
    //添加题标
    UILabel *BarNameLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 74, 200, 30)];
    BarNameLb.text = @"品牌买/卖统计";
    BarNameLb.textAlignment = NSTextAlignmentLeft;
    BarNameLb.textColor = [UIColor whiteColor];
    [self.view addSubview:BarNameLb];
    
    UILabel *BarUnitLb = [[UILabel alloc]initWithFrame:CGRectMake(10, 104, 200, 30)];
    BarUnitLb.text = @"(单位:个)";
    BarUnitLb.font = [UIFont systemFontOfSize:12];
    BarUnitLb.textAlignment = NSTextAlignmentLeft;
    BarUnitLb.textColor = [UIColor whiteColor];
    [self.view addSubview:BarUnitLb];
    for (int i = 0; i<2; i++) {
        CGFloat X = self.view.frame.size.width - (i + 1) * 50;
        CGFloat Y = 91;
        UIView *legendView = [[UIView alloc]init];
        legendView.frame = CGRectMake(X,Y, 10, 10);
        legendView.layer.cornerRadius = 5.0f;
        legendView.layer.masksToBounds = true;
        UILabel *legendLb = [[UILabel alloc]init];
        legendLb.frame = CGRectMake(X+15, Y, 45, 10);
        legendLb.font = [UIFont systemFontOfSize:10];
        legendLb.textColor = [UIColor whiteColor];
        if (i == 1) {
            legendView.backgroundColor = [UIColor colorWithRed:(250/255.0)  green:(246/255.0)  blue:(80/255.0)  alpha:1.0];
            legendLb.text = @"买入";
        }else{
            legendView.backgroundColor = [UIColor colorWithRed:(141/255.0)  green:(205/255.0)  blue:(245/255.0)  alpha:1.0];
            legendLb.text = @"卖出";
        }
        [self.view addSubview:legendView];
        [self.view addSubview:legendLb];
    }
}




@end
