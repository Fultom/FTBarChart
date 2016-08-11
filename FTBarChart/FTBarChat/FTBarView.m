//
//  FTBarView.m
//  FTBarChart
//
//  Created by 徐法同 on 16/7/26.
//  Copyright © 2016年 徐法同. All rights reserved.
//

#import "FTBarView.h"


@interface FTBarView ()

@property (nonatomic, strong)UIView *view1;
@property (nonatomic, strong)UIView *view2;

@end
@implementation FTBarView

-(void)layoutSubviews
{
    [super layoutSubviews];
    [UIView animateWithDuration:0.8 animations:^{
        CGRect Bar_1 = _view1.frame;
        Bar_1.size.height = _heightOfBar_1;
        Bar_1.origin.y = self.frame.size.height - _heightOfBar_1;
        _view1.frame = Bar_1;
    }];
    
    [UIView animateWithDuration:0.8 animations:^{
        CGRect Bar_2 = _view2.frame;
        Bar_2.size.height = _heightOfBar_2;
        Bar_2.origin.y = self.frame.size.height - _heightOfBar_2;
        _view2.frame = Bar_2;
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self.backgroundColor = [UIColor whiteColor];
    self = [super initWithFrame:frame];
    if (self) {
        _view1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, (frame.size.width-1) *0.5, 0)];
        _view1.backgroundColor = [UIColor colorWithRed:(250/255.0)  green:(246/255.0)  blue:(80/255.0)  alpha:1.0];
        [self addSubview:_view1];
        _view2 = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width *0.5+0.5, self.frame.size.height, (self.frame.size.width-1) *0.5, 0)];
        
        _view2.backgroundColor = [UIColor colorWithRed:(141/255.0)  green:(205/255.0)  blue:(245/255.0)  alpha:1.0];

        [self addSubview:_view2];
    }
    return self;
}


-(void)setHeightOfBar_1:(CGFloat)heightOfBar_1
{
    _heightOfBar_1 = heightOfBar_1;
}


-(void)setHeightOfBar_2:(CGFloat)heightOfBar_2
{
    _heightOfBar_2 = heightOfBar_2;
}

@end
