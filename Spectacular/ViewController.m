//
//  ViewController.m
//  Spectacular
//
//  Created by BloodBorne on 15-4-28.
//  Copyright (c) 2015年 VVV. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,strong)UIImageView *firstImageView;
@property (nonatomic,strong)UIImageView *secondImageView;
@property (nonatomic) CGFloat xOfFirstImageView;
@property (nonatomic) CGFloat xOfSecondImageView;
@end

@implementation ViewController

-(CGFloat)xOfFirstImageView
{
    if(!_xOfFirstImageView) _xOfFirstImageView = 0.0;
    return _xOfFirstImageView;
}

-(CGFloat)xOfSecondImageView
{
    if(!_xOfSecondImageView) _xOfSecondImageView = self.view.frame.size.width;
    return _xOfSecondImageView;
}

-(UIImageView *)firstImageView
{
    if(!_firstImageView)
    {
        _firstImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.xOfFirstImageView, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _firstImageView.image = [UIImage imageNamed:@"green"];
    }
    return _firstImageView;
}

-(UIImageView *)secondImageView
{
    if(!_secondImageView)
    {
        _secondImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.xOfSecondImageView, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _secondImageView.image = [UIImage imageNamed:@"red"];
    }
    return _secondImageView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    CGSize contentSize=CGSizeMake(self.view.frame.size.width*3, 0);
    self.scrollView.contentSize = contentSize;

    [self.scrollView addSubview:self.firstImageView];
    [self.scrollView addSubview:self.secondImageView];
    
//    UIImageView *view1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    view1.image = [UIImage imageNamed:@"green"];
//    [self.scrollView addSubview:view1];
//    
//    UIImageView *view2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    view2.image = [UIImage imageNamed:@"red"];
//    [self.scrollView addSubview:view2];
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = 1;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger neareastNumber = lround(fractionPage);
    
    if(self.pageControl.currentPage != neareastNumber)
    {
        self.pageControl.currentPage = neareastNumber;
        
        if(self.pageControl.currentPage % 2 ==1)
        {
            self.xOfFirstImageView += pageWidth*2;
            self.xOfSecondImageView += pageWidth*2;
            self.firstImageView = nil;
            self.secondImageView = nil;
            [self.scrollView addSubview:self.firstImageView];
            [self.scrollView addSubview:self.secondImageView];
        }
    }
    
    NSLog(@"%f",fractionPage);
}

@end
