//
//  FTBarChart.h
//  FTBarChart
//
//  Created by 徐法同 on 16/7/26.
//  Copyright © 2016年 徐法同. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Bar_botton_y 30 //统计图下方的空隙距离
//#define Bar_Space 

@interface FTBarChart : UIView

/** 背景的最大高度 */
@property (nonatomic, assign) CGFloat MaxHeight;
/** 下方文字的数组 */
@property (nonatomic, strong) NSArray *TextArray;
/** 每个条形的数量 */
@property (nonatomic, strong) NSArray *NumberArray;

//数据源
@property (nonatomic, strong) NSArray *dataSourceArr;


//popview显示的柱状图参数
@property (nonatomic, copy) void(^popViewStartBlock)(NSString *value);
@property (nonatomic, copy) void(^popViewCloseBlock)();

- (instancetype)initWithFrame:(CGRect)frame
                 theMostValue:(CGFloat)theMostValue
                   dateSource:(NSArray *)dataArray;

@end
