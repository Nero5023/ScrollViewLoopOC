//
//  NLoopSrollView.m
//  ScrollViewLoop
//
//  Created by Nero Zuo on 15/7/31.
//  Copyright (c) 2015年 Nero Zuo. All rights reserved.
//

#import "NLoopScrollView.h"
#import "NScrollImageModel.h"

@interface NLoopScrollView()<UIScrollViewDelegate>

@end

@implementation NLoopScrollView {
    NSTimer *_timer;
    UIPageControl *_pageControl;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    super.delegate = self;
    self.hidden = YES;
    self.pagingEnabled = true;
    self.showsHorizontalScrollIndicator = false;
    self.showsVerticalScrollIndicator = false;
    self.isAutoSlip = true;
    self.period = 3.0;
    self.pageIndicatorTintColor = [UIColor grayColor];
    self.currentPageIndicatorTintColor = [UIColor blackColor];
    return self;
}


- (void)show {
    if (_isAutoSlip) {
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_period target:self selector:@selector(slipPictures) userInfo:nil repeats:YES];
    }

    self.hidden = NO;
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_isAutoSlip) {
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:_period target:self selector:@selector(slipPictures) userInfo:nil repeats:YES];
    }
    
    int page = floor((scrollView.contentOffset.x - scrollView.frame.size.width/2)/scrollView.frame.size.width) + 1;
//    NSLog(@"%d",page);
    int totalPages = floor(scrollView.contentSize.width / scrollView.frame.size.width);
//    NSLog(@"total:%d",totalPages);
//    NSLog(@"%f",scrollView.contentOffset.x);
    if(page == 0){
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width* (totalPages -2), 0.0) animated:NO];
        _pageControl.currentPage = totalPages - 1;
        return;
    }
    
    if(page == totalPages - 1) {
        [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0.0) animated:NO];
        _pageControl.currentPage = 0;
        return;
    }
    _pageControl.currentPage = page - 1;
    
}

- (void)layoutViewInScoreViewWithImages: (NSArray *)imagesModels {
    
    
    self.contentSize = CGSizeMake(self.frame.size.width * (imagesModels.count+2), self.frame.size.height);
    BOOL isImage = false;
    
    if ([[imagesModels firstObject]isKindOfClass:[UIImage class]]) {
        isImage = true;
    }
    
    for (int i = 0; i < imagesModels.count; i++) {
        UIImageView *imageView;
        if (isImage) {
            imageView = [[UIImageView alloc] initWithImage:imagesModels[i]];
        }else {
            NScrollImageModel *imageModel = imagesModels[i];
            imageView = [[UIImageView alloc] initWithImage:imageModel.image];
        }
        
        
        imageView.frame = CGRectMake((i+1)*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapImage:)];
        [imageView addGestureRecognizer:tap];
    }
    UIImageView *imageViewLast ;
//    = [[UIImageView alloc] initWithImage:[imagesModels lastObject]];
    UIImageView *imageViewFirst ;
//    = [[UIImageView alloc] initWithImage:[imagesModels firstObject]];
  
    if (isImage) {
        imageViewFirst = [[UIImageView alloc] initWithImage:[imagesModels firstObject]];
        imageViewLast = [[UIImageView alloc] initWithImage:[imagesModels lastObject]];
    }else {
        NScrollImageModel *firstImageModel = [imagesModels firstObject];
        NScrollImageModel *lastImageModel = [imagesModels lastObject];
        imageViewFirst = [[UIImageView alloc] initWithImage:firstImageModel.image];
        imageViewLast = [[UIImageView alloc] initWithImage:lastImageModel.image];
    }
    
    imageViewLast.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    imageViewFirst.frame = CGRectMake((imagesModels.count+1) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:imageViewFirst];
    [self addSubview:imageViewLast];
    [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+self.frame.size.height - 22, self.frame.size.width, 22)];
    _pageControl.numberOfPages = imagesModels.count;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = self.pageIndicatorTintColor;
    _pageControl.currentPageIndicatorTintColor = self.currentPageIndicatorTintColor;
    [self.superview addSubview:_pageControl];
}


-(void)slipPictures {
    [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.contentOffset = CGPointMake( (_pageControl.currentPage + 2)* self.frame.size.width, 0.0);
    } completion:^(BOOL finished) {
        if (finished) {
            
            int page = floor((self.contentOffset.x - self.frame.size.width/2)/self.frame.size.width) + 1;
            int totalPages = floor(self.contentSize.width / self.frame.size.width);
            if(_pageControl.currentPage == totalPages - 3) {
                [self setContentOffset:CGPointMake(self.frame.size.width, 0.0) animated:NO];
                _pageControl.currentPage = 0;
                return;
            }
            _pageControl.currentPage = page - 1;
        }
    }];
    
}

- (void)didTapImage:(UITapGestureRecognizer *)tap{
    self.tapBlock(tap.view.tag);
}
@end
