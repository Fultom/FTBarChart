//
//  FTBarChartMessage.h
//  FTBarChart
//
//  Created by 徐法同 on 16/7/26.
//  Copyright © 2016年 徐法同. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "FTBarChartMessage.h"
#import "FTBarChart.h"

@interface FTBarChartMessage : NSObject

//占比
//+ (CGFloat)theTotalBaseData:(CGFloat)basedata onedayBase:(CGFloat)adata;

//cell 高度
//+ (CGFloat)cellHeight


// 根据一个最大值 创建左侧刻度数组
+ (NSArray *)showTheYcoordinates:(CGFloat)value;

// 数值在屏幕中的高度比重
+ (CGFloat)valueOfHeightRatiovalue:(CGFloat)value thanValue:(CGFloat)value2;
@end
