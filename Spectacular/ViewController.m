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
@property (nonatomic,strong)UIImageView *lastImageView;
@property (nonatomic) CGFloat xOfFirstImageView;
@property (nonatomic) CGFloat xOfSecondImageView;
@property (nonatomic) int currentPage;
@property (nonatomic) float oldX;
@end

@implementation ViewController

#define PAGE_NUMBER 10

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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollView.delegate = self;
    
    CGSize contentSize=CGSizeMake(self.view.frame.size.width*PAGE_NUMBER, 0);
    self.scrollView.contentSize = contentSize;
    
    
    
    self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    
    
    
    [self loadCustomViewsWithInitialPageNumber:0];
    
}

-(void)loadCustomViewsWithInitialPageNumber:(int)initialPageNumber
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int i=0;
    for( ;initialPageNumber<PAGE_NUMBER;initialPageNumber++,i++)
    {
        
        if(initialPageNumber%2==0)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(pageWidth * i , 0, self.view.frame.size.width, self.view.frame.size.height)];
            imageView.image = [UIImage imageNamed:@"green"];
            [self.scrollView addSubview:imageView];
        }
        else
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(pageWidth * i, 0, self.view.frame.size.width, self.view.frame.size.height)];
            imageView.image = [UIImage imageNamed:@"red"];
            [self.scrollView addSubview:imageView];
        }
    }
}

//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    CGFloat pageWidth = self.scrollView.frame.size.width;
//    float fractionPage = self.scrollView.contentOffset.x / pageWidth;
//    NSInteger neareastNumber = lround(fractionPage);
//    
//    //NSLog(@"%f %f",fractionPage,0.5*pageWidth);
//    
//    if(neareastNumber > self.pageControl.currentPage)
//    {
//        //self.lastImageView = self.scrollView.subviews[self.currentPage];
//        //[self.lastImageView removeFromSuperview];
//        
//        //self.pageControl.numberOfPages -- ;
//        
//        self.pageControl.currentPage++;
//        self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
//        self.currentPage++;
//    }
//    else if(neareastNumber < self.pageControl.currentPage)
//    {
//        self.pageControl.currentPage--;
//    }
//    //NSLog(@"%d",self.currentPage);
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    float fractionPage = self.scrollView.contentOffset.x / pageWidth;
    NSInteger neareastNumber = lround(fractionPage);
    
    //NSLog(@"%f %f",fractionPage,0.5*pageWidth);
    
    if(neareastNumber > self.oldX)
    {
        self.lastImageView = self.scrollView.subviews[self.currentPage];
        if(self.lastImageView)
            //[self.lastImageView removeFromSuperview];
        
        self.pageControl.numberOfPages -- ;
        
        //self.pageControl.currentPage++;
        self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        //self.currentPage++;
        self.oldX = neareastNumber;
        //CGSize contentSize=CGSizeMake(self.scrollView.contentSize.width - pageWidth , 0);
        //self.scrollView.contentSize = contentSize;
        NSLog(@"here1~~");
    }
    else if(neareastNumber < self.oldX)
    {
        NSLog(@"back");
        [self.scrollView setContentOffset:CGPointMake(pageWidth * self.oldX , 0) animated:YES];
        //self.scrollView.decelerationRate = 1;
    }
    NSLog(@"%d %f %f",neareastNumber,self.oldX,pageWidth * self.oldX);
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat pageWidth = self.scrollView.frame.size.width;
//    float fractionPage = self.scrollView.contentOffset.x / pageWidth;
//    NSInteger neareastNumber = lround(fractionPage);
//    if(neareastNumber <= self.oldX)
//    {
//        NSLog(@"backon");
////        [self.scrollView setContentOffset:CGPointMake(pageWidth * self.oldX , 0)];
//        [self.scrollView setContentOffset:CGPointMake(pageWidth * self.oldX , 0) animated:YES];
//        self.scrollView.decelerationRate = 1;
//    }
//
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if(scrollView.contentOffset.x < self.oldX)
//        [scrollView setContentOffset:CGPointMake(self.oldX, scrollView.contentOffset.y)];
//    else
//        self.oldX = scrollView.contentOffset.x;
//}

@end
