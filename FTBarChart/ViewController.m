//
//  ViewController.m
//  FTBarChart
//
//  Created by 徐法同 on 16/7/26.
//  Copyright © 2016年 徐法同. All rights reserved.
//

#import "ViewController.h"
#import "FTBarChartViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)nextBtnClick:(UIButton *)sender {
    FTBarChartViewController *next = [FTBarChartViewController new];
    [self.navigationController pushViewController:next animated:YES];
    
}

@end
