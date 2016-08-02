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



-(NSArray *)dataSourceArr
{
    if (_dataSourceArr == nil) {
        _dataSourceArr = @[@"万色水母", @"飞兰", @"万色益+",@"万色益+", @"其它"];
    }
    return _dataSourceArr;
}


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
//    _theMostValue = [DayBarChartMessage getTheMostValueFromTheArray:_dataSourceArr];
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
    
    UIColor *colorOne = [UIColor colorWithRed:(165/255.0) green:(131/255.0) blue:(200/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(200/255.0)  green:(193/255.0)  blue:(195/255.0)  alpha:1.0];
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
    for (NSString *str in self.Yarray) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height - Bar_botton_y -16 - i * 20, 50, 20)];
        label.text = str;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        
        UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(50, self.frame.size.height - Bar_botton_y - i * 20, self.frame.size.width - 70, 0.7)];
        divider.backgroundColor = [UIColor whiteColor];
        divider.alpha = 0.3;
        [self addSubview:divider];
        
        i++;
    }
}

//创建X坐标
- (void)setupTheXcoordinates{
    int i = 0;
    NSInteger k;
    k = self.TextArray.count;
    for (NSString *str in self.TextArray) {
        
        CGFloat space = 20;
        CGFloat hViewW = ((self.frame.size.width - 50 - 30) - space *(k+1)) /k;
        CGFloat hViewX = (50 + space + (self.frame.size.width - 50 - 30) / k * (i));
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(hViewX, self.frame.size.height - Bar_botton_y - 16 + 20, hViewW, 20)];
        label.text = str;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
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
        CGFloat space = 20;
        CGFloat hViewW = ((self.frame.size.width - 50 -30) - space *(ArrCount+1)) /ArrCount;
        CGFloat hViewX = (50 + space + (self.frame.size.width - 50 -30) / ArrCount * (i - 1));
        FTBarView *hView = [[FTBarView alloc] initWithFrame:CGRectMake(hViewX, (self.frame.size.height - _MaxHeight - Bar_botton_y), hViewW, _MaxHeight)];
        hView.heightOfBar_1 = [BarHeightArr[0]floatValue] *_MaxHeight;
        hView.heightOfBar_2 = [BarHeightArr[1]floatValue] *_MaxHeight;
        hView.alpha = 0.8;
        hView.tag = i;
        [self addSubview:hView];
        
        UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        singleRecognizer.numberOfTapsRequired = 1;
        [hView addGestureRecognizer:singleRecognizer];
    }
}

-(void)singleTap:(UITapGestureRecognizer*)recognizer
{
    UILabel *popLabel = [[UILabel alloc] init];
    FTBarView *view = (FTBarView *)recognizer.view;
    CGFloat x = view.frame.origin.x - 1.5;
    CGFloat y = view.frame.origin.y;
    NSInteger value0 = [self.NumberArray[view.tag-1][0]integerValue];
    NSInteger value1 = [self.NumberArray[view.tag-1][1]integerValue];
    NSString *valueStr = [NSString stringWithFormat:@"收入:%ld\n支出:%ld", value0,value1];
    if (value0 > value1) {
        y = self.frame.size.height - view.heightOfBar_1;
    }else{
        y = self.frame.size.height - view.heightOfBar_2;
    }

    
    [UIView animateWithDuration:0.3 animations:^{
        view.alpha = 1;
        if (self.popViewStartBlock) {
            self.popViewStartBlock(valueStr);
        }
        popLabel.frame = CGRectMake(x - 10, y - Bar_botton_y - 40 , 70, 40);
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.numberOfLines = 0;
        popLabel.text = valueStr;
        popLabel.font = [UIFont systemFontOfSize:10];
        popLabel.textColor = [UIColor redColor];
        
        popLabel.backgroundColor = [UIColor lightTextColor];
        
        [self addSubview:popLabel];
    } completion:^(BOOL finished) {
        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0.8;
                if (self.popViewCloseBlock) {
                    self.popViewCloseBlock();
                }
                [popLabel removeFromSuperview];
            }];
        });
    }];
}



- (NSArray *)TextArray {
    if (!_TextArray) {
        _TextArray = [NSArray arrayWithObjects:@"万色益+",@"万色水母", @"万色益+", @"其它", nil];
    }
    return _TextArray;
}




@end
