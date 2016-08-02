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
    FTBarChart  *barchart = [[FTBarChart alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 455) theMostValue:450 dateSource:nil];
    barchart.MaxHeight = 200;
    barchart.dataSourceArr = @[@[@0.5,@0.8],@[@0.5,@0.8],@[@0.5,@0.8],@[@0.5,@0.8],];
    barchart.NumberArray = @[@[@566,@978],@[@566,@978],@[@566,@978],@[@566,@978]];
    [self.view addSubview:barchart];
}




@end
