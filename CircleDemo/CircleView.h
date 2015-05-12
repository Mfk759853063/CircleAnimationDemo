//
//  CircleView.h
//  CircleDemo
//
//  Created by huayu on 15/5/6.
//  Copyright (c) 2015年 huayu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView

@property (assign, nonatomic) CGFloat duration;

- (instancetype)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)strokeWidth insets:(UIEdgeInsets)insets;

@end
