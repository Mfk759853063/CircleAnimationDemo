//
//  CircleView.m
//  CircleDemo
//
//  Created by huayu on 15/5/6.
//  Copyright (c) 2015年 huayu. All rights reserved.
//

#import "CircleView.h"
#import "UIColor+MLPFlatColors.h"

@interface CircleView()
@property (strong, nonatomic) NSMutableArray *progressLayers;
@property (strong, nonatomic) UIBezierPath *circlePath;
@property (strong, nonatomic) CAShapeLayer *currentPropressLayer;
@property (strong, nonatomic) CAShapeLayer *backgroundLayer;
@property (assign, nonatomic) CGFloat strokeWidth;
@property (assign, getter=isCircleComplete, nonatomic) BOOL circleComplete;

@end

@implementation CircleView

- (instancetype)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)strokeWidth insets:(UIEdgeInsets)insets
{
    self = [super initWithFrame:frame];
    if (self) {
        self.duration = 45.0f;
        self.strokeWidth = strokeWidth;
        self.progressLayers = [NSMutableArray array];
        CGPoint arcCeter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        CGFloat radius = CGRectGetMidX(self.bounds);
        self.circlePath = [UIBezierPath bezierPathWithArcCenter:arcCeter radius:radius startAngle:0 endAngle:M_PI * 2 - M_PI_4/2 clockwise:YES];
        
        [self addBackgroundLayer];
    }
    return self;
}

- (void)addBackgroundLayer
{
    self.backgroundLayer = [CAShapeLayer layer];
    self.backgroundLayer.frame = self.bounds;
    self.backgroundLayer.path = self.circlePath.CGPath;
    self.backgroundLayer.strokeColor = [UIColor redColor].CGColor;
    self.backgroundLayer.fillColor = [UIColor clearColor].CGColor;
    self.backgroundLayer.lineWidth = self.strokeWidth;

    [self.layer addSublayer:self.backgroundLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.f;
    animation.fromValue = @(0.f);
    animation.toValue = @(2 * M_PI);
    animation.repeatCount = INFINITY;
    [self.backgroundLayer addAnimation:animation forKey:@"rorationd"];
//
    CABasicAnimation *headAnimation = [CABasicAnimation animation];
    headAnimation.keyPath = @"strokeStart";
    headAnimation.beginTime = .8f;
    headAnimation.duration = 2.5f;
    headAnimation.fromValue = @(0.f);
    headAnimation.toValue = @(1.f);
    headAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
//
    CABasicAnimation *tailAnimation = [CABasicAnimation animation];
    tailAnimation.keyPath = @"strokeEnd";
    tailAnimation.duration = 1.f;
    tailAnimation.fromValue = @(0.f);
    tailAnimation.toValue = @(1.f);
    tailAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
//
//    
//    CABasicAnimation *endHeadAnimation = [CABasicAnimation animation];
//    endHeadAnimation.keyPath = @"strokeStart";
//    endHeadAnimation.beginTime = 1.f;
//    endHeadAnimation.duration = 0.5f;
//    endHeadAnimation.fromValue = @(0.25f);
//    endHeadAnimation.toValue = @(1.f);
//    endHeadAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
//
//    CABasicAnimation *endTailAnimation = [CABasicAnimation animation];
//    endTailAnimation.keyPath = @"strokeEnd";
//    endTailAnimation.beginTime = 1.f;
//    endTailAnimation.duration = 0.5f;
//    endTailAnimation.fromValue = @(1.f);
//    endTailAnimation.toValue = @(1.f);
//    endTailAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];;
//    
    CAAnimationGroup *animations = [CAAnimationGroup animation];
    [animations setDuration:2.0f];
    [animations setAnimations:@[headAnimation,tailAnimation]];
    animations.repeatCount = INFINITY;
    [self.backgroundLayer addAnimation:animations forKey:@"animations"];
}


- (void)addNewLayer
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = self.circlePath.CGPath;
    shapeLayer.strokeColor = [UIColor randomFlatColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = self.strokeWidth;
    shapeLayer.strokeEnd = 0.f;
    [self.progressLayers addObject:shapeLayer];
    self.currentPropressLayer = shapeLayer;
}

- (void)updateAnimations
{
    CGFloat duration = self.duration * (1.0f - [self.progressLayers.firstObject strokeEnd]);
    CGFloat strokeEndFinal = 1.0f;
    for (CAShapeLayer *progressLayer in self.progressLayers) {
        CABasicAnimation *strokeAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeAnimation.duration = duration;
        strokeAnimation.fromValue = @(progressLayer.strokeEnd);
        strokeAnimation.toValue = @(strokeEndFinal);
        strokeAnimation.autoreverses = NO;
        strokeAnimation.repeatCount = 0;
        CGFloat previousStorkeEnd = progressLayer.strokeEnd;
        progressLayer.strokeEnd = strokeEndFinal;
    }
}

#pragma mark override
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    if (self.isCircleComplete == NO) {
//        [self addNewLayer];
//    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
