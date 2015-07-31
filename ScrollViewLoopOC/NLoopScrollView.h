//
//  NLoopSrollView.h
//  ScrollViewLoop
//
//  Created by Nero Zuo on 15/7/31.
//  Copyright (c) 2015年 Nero Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapBlock) (NSInteger);

@interface NLoopScrollView : UIScrollView

@property (nonatomic,assign) BOOL isAutoSlip;
@property (nonatomic,assign) NSTimeInterval period;
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;
@property (nonatomic,strong) UIColor *currentPageIndicatorTintColor;

@property (copy) TapBlock tapBlock;
- (void)layoutViewInScoreViewWithImages: (NSArray *)imageModels;
- (void)show;
- (instancetype)initWithFrame:(CGRect)frame ;


@end
