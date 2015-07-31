//
//  ViewController.m
//  ScrollViewLoopOC
//
//  Created by Nero Zuo on 15/7/31.
//  Copyright (c) 2015年 Nero Zuo. All rights reserved.
//

#import "ViewController.h"
#import "NLoopScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    NLoopScrollView *nScrollView = [[NLoopScrollView alloc] initWithFrame:CGRectMake(0, 200, screenWidth, 90.0)];
    UIImage *image0 = [UIImage imageNamed:@"0"];
    UIImage *image1 = [UIImage imageNamed:@"1"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    [self.view addSubview:nScrollView];
    [nScrollView layoutViewInScoreViewWithImages:@[image0,image1,image2]];
    [nScrollView show];
    nScrollView.tapBlock = ^(NSInteger index){
        NSLog(@"%ld", (long)index);
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
