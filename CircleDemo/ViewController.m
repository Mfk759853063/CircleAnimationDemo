//
//  ViewController.m
//  CircleDemo
//
//  Created by huayu on 15/5/6.
//  Copyright (c) 2015年 huayu. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CircleView *circleView = [[CircleView alloc] initWithFrame:self.view.bounds strokeWidth:5 insets:UIEdgeInsetsZero];
    [self.view addSubview:circleView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
