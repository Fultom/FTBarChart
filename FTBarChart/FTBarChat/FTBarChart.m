//
//  FTBarChart.m
//  FTBarChart 
//
//  Created by 徐法同 on 16/7/26.
//  Copyright © 2016年 徐法同. All rights reserved.
//

#import "FTBarChart.h"
#import "FTBarChartMessage.h"
#import "FTBarView.h"
#import <QuartzCore/QuartzCore.h>

@interface FTBarChart ()

@property (nonatomic, assign) CGFloat theMostValue;
@property (nonatomic, strong) NSArray *Yarray;

@end

@implementation FTBarChart


- (instancetype)initWithFrame:(CGRect)frame
                 theMostValue:(CGFloat)theMostValue
                   dateSource:(NSArray *)dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        _dataSourceArr = dataArray;
        _theMostValue = theMostValue;
        [self loadData];
        [self insertColorGradient];
    }
    return self;
}

#pragma mark ----LoadData
- (void)loadData {
    _Yarray = [FTBarChartMessage showTheYcoordinates:_theMostValue];
}
#pragma mark ------setup UI

- (void)drawRect:(CGRect)rect {
    [self setupTheYcoordinates];
    [self setupTheXcoordinates];
    [self setupTheHistogramView];
}
//color gradient layer 不透明
- (void) insertColorGradient {
    
    UIColor *colorOne = [UIColor colorWithRed:(217/255.0) green:(0/255.0) blue:(80/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(217/255.0) green:(0/255.0) blue:(80/255.0) alpha:1.0];//[UIColor purpleColor];//[UIColor colorWithRed:(180/255.0)  green:(150/255.0)  blue:(100/255.0)  alpha:1.0];
//
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = self.bounds;
    
    [self.layer insertSublayer:headerLayer above:0];
    
}

//创建Y坐标
- (void)setupTheYcoordinates{
    int i = 0;
    CGFloat spaceY = 0.0;
    for (NSString *str in self.Yarray) {
        
        NSInteger count = self.Yarray.count + 1;
        CGFloat Bar_Space = (self.frame.size.height - Bar_botton_y - (0.7 * count)-30)/count;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - Bar_botton_y -16 - i * Bar_Space, 50, 20)];
        label.text = str;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(50, self.frame.size.height - Bar_botton_y - i * Bar_Space, self.frame.size.width - 70, 0.7)];
        divider.backgroundColor = [UIColor whiteColor];
        divider.alpha = 0.3;
        [self addSubview:divider];
        CGFloat maxHeight;
        CGFloat minxHeight;
        if (i==0) {
            maxHeight = label.frame.origin.y;
            divider.alpha = 1.0f;
        }
        if (i == count - 2) {
            minxHeight = label.frame.origin.y;
            spaceY = minxHeight;
        }
        _MaxHeight = maxHeight - minxHeight;
        i++;
    }
    UIView *vertical = [[UIView alloc]initWithFrame:CGRectMake(50, spaceY, 0.7, _MaxHeight + 20)];
    vertical.backgroundColor = [UIColor whiteColor];
    [self addSubview:vertical];
}

//创建X坐标
- (void)setupTheXcoordinates{
    int i = 0;
    NSInteger k;
    k = self.TextArray.count;
    for (NSString *str in self.TextArray) {
        
        CGFloat space = 10;
        CGFloat hViewW = ((self.frame.size.width - 50 - 30) - space *(k+1)) /k+10;
        CGFloat hViewX = (50 + space + (self.frame.size.width - 50 - 30) / k * (i))-5;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(hViewX, self.frame.size.height - Bar_botton_y - 16 + 20, hViewW, 20)];
        label.text = str;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:9];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        i++;
    }
}

//给你个柱子
- (void)setupTheHistogramView {
    int i = 0;
    
    for (NSArray *BarHeightArr in self.dataSourceArr) {
        i++;
        NSUInteger ArrCount = self.dataSourceArr.count;
        CGFloat space = 10;
        CGFloat hViewW = ((self.frame.size.width - 50 -30) - space *(ArrCount+1)) /ArrCount;
        CGFloat hViewX = (50 + space + (self.frame.size.width - 50 -30) / ArrCount * (i - 1));
        FTBarView *hView = [[FTBarView alloc] initWithFrame:CGRectMake(hViewX, (self.frame.size.height - _MaxHeight - Bar_botton_y), hViewW, _MaxHeight)];
        hView.heightOfBar_1 = [BarHeightArr[0]floatValue] *_MaxHeight;
        hView.heightOfBar_2 = [BarHeightArr[1]floatValue] *_MaxHeight;
        hView.tag = i;
        [self addSubview:hView];
        
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [hView addGestureRecognizer:singleRecognizer];
    }
}

-(void)singleTap:(UITapGestureRecognizer*)recognizer
{
    FTBarView *view = (FTBarView *)recognizer.view;
    CGFloat x = view.frame.origin.x - 1.5;
    CGFloat y = view.frame.origin.y;
    
    NSInteger value0 = [self.NumberArray[view.tag-1][0] integerValue];
    NSInteger value1 = [self.NumberArray[view.tag-1][1] integerValue];
    NSString *valueStr = [NSString stringWithFormat:@"买入:%ld\n卖出:%ld", value0,value1];
    if (value0 > value1) {
        y = self.frame.size.height - view.heightOfBar_1;
    }else{
        y = self.frame.size.height - view.heightOfBar_2;
    }
    //中心位置
    CGFloat centerX = CGRectGetMaxX(view.frame) - view.frame.size.width* 0.5;
    CGFloat centerY = y - Bar_botton_y -20;
    
     UILabel *popLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 55, 0 )];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x - 10, y - Bar_botton_y - 45, 55, 0)];
    bgImageView.center = CGPointMake(centerX, centerY);
    
    
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 1;
        if (weakSelf.popViewStartBlock) {
            weakSelf.popViewStartBlock(valueStr);
        }
        bgImageView.frame = CGRectMake(x - 10, y - Bar_botton_y - 40, 55, 40);
        bgImageView.center = CGPointMake(centerX, centerY);
        bgImageView.image = [UIImage imageNamed:@"Statistics_With_Bubbles"];
       
        popLabel.frame = CGRectMake(0, 0 , 55, 35);
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.numberOfLines = 0;
        popLabel.text = valueStr;
        popLabel.font = [UIFont systemFontOfSize:10];
        popLabel.textColor = [UIColor blackColor];
        [bgImageView addSubview:popLabel];
        [weakSelf addSubview:bgImageView];
    } completion:^(BOOL finished) {
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.3 animations:^{
                if (weakSelf.popViewCloseBlock) {
                    weakSelf.popViewCloseBlock();
                }
                [bgImageView removeFromSuperview];
            }];
        });
    }];
}



@end
