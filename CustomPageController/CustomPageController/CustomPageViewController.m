//
//  ViewController.m
//  CustomPageController
//
//  Created by Aditya Deshmane on 02/02/14.
//  Copyright (c) 2014 Aditya Deshmane. All rights reserved.
//

#import "CustomPageViewController.h"

@interface CustomPageViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *_pageTitleLabelArray;
    NSMutableArray *_pageViewControllerArray;
    int pageCount;
    int _pageNo;
}

@property (weak, nonatomic) IBOutlet UIScrollView *topTitleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomPageDataScrollView;

-(void)setupUI;
-(void)setupTitleScrollView;
-(void)setupBottomPageScrollView;

@end

@implementation CustomPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    _pageNo = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


-(void)setupUI
{
    pageCount = 3;
    
    /*** Set title UILabel array ***/
    
    //red
    UILabel *titleLabelOne = [[UILabel alloc] init];
    titleLabelOne.text = @"RED";
    titleLabelOne.textAlignment = NSTextAlignmentCenter;
    titleLabelOne.textColor = [UIColor redColor];
    
    //green
    UILabel *titleLabelTwo = [[UILabel alloc] init];
    titleLabelTwo.text = @"GREEN";
    titleLabelTwo.textAlignment = NSTextAlignmentCenter;
    titleLabelTwo.textColor = [UIColor greenColor];
    
    //blue
    UILabel *titleLabelThree = [[UILabel alloc] init];
    titleLabelThree.text = @"BLUE";
    titleLabelThree.textAlignment = NSTextAlignmentCenter;
    titleLabelThree.textColor = [UIColor blueColor];
    
    _pageTitleLabelArray = [[NSMutableArray alloc] initWithObjects:titleLabelOne,titleLabelTwo,titleLabelThree, nil];

    
    
    /*** Set view's to be displayed in bottom scrollview and add view's controllers to '_pageViewControllerArray' ***/
    
    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //red
    UIViewController *redContentViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"PAGE_CONTENT_VIEW_CONTROLLER"];
    [redContentViewController.view setBackgroundColor:[UIColor redColor]];
    
    //green
    UIViewController *greenContentViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"PAGE_CONTENT_VIEW_CONTROLLER"];
    [greenContentViewController.view setBackgroundColor:[UIColor greenColor]];

    //blue
    UIViewController *blueContentViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"PAGE_CONTENT_VIEW_CONTROLLER"];
    [blueContentViewController.view setBackgroundColor:[UIColor blueColor]];

    
    _pageViewControllerArray = [[NSMutableArray alloc] initWithObjects:redContentViewController,
                               greenContentViewController,
                               blueContentViewController,
                               nil];
    
    //Set scroll view's
    [self setupTitleScrollView];
    [self setupBottomPageScrollView];
}



-(void)setupTitleScrollView
{
    /*********** Title ScrollView Setup ************/

    
    //Disable title view's user interaction
    _topTitleScrollView.userInteractionEnabled = NO;
    
    
    // 1. Title scroll view content width calculation
    
    // Formula: content width = (screenWidth/2) + pageCount * (screenWidth/2)
    int titleScrollContentWidth = 160 + pageCount * 160;
    
    [_topTitleScrollView setContentSize:CGSizeMake(titleScrollContentWidth, _topTitleScrollView.frame.size.height)];
    
    
    // 2. Adding title uilabel as Title scroll view's subview
    
    int pageNo = 1;
    
    for (UILabel *pageTitleLabel in _pageTitleLabelArray)
    {
        pageTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        /* Title label frame calculation */
        
        // Formula: xPos = 75 + 10 * pageNo + (pageNo -1) * 150;
        // Where,
        // pageNo starts with 1
        // 75 = Left margin of first title
        // 10 = Space between two labels
        // 150 = Width of label
        
        int xPos = 75 + 10 * pageNo + (pageNo -1) * 150;
        int margin = 1;  //top and bottom margin
        int height = _topTitleScrollView.frame.size.height - (margin * 2);
        
        pageTitleLabel.frame = CGRectMake(xPos, margin, 150, height);

        pageNo ++;
        
        [_topTitleScrollView addSubview:pageTitleLabel];
    }
}



-(void)setupBottomPageScrollView
{
    /*********** Bottom Scroll View ************/
    
    _bottomPageDataScrollView.delegate = self;
    _bottomPageDataScrollView.pagingEnabled = YES;
    [_bottomPageDataScrollView setShowsHorizontalScrollIndicator:NO];
    [_bottomPageDataScrollView setShowsVerticalScrollIndicator:NO];
    
    //Let scrollview accelerate with some low value
    _bottomPageDataScrollView.decelerationRate = 0.2;
    
    
    // 1. Details scroll view content width calculation
    
    // Formula: content width = scrollViewWidth * NoOfPages
    int detailScrollContentWidth = _bottomPageDataScrollView.frame.size.width * pageCount;
    
    [_bottomPageDataScrollView setContentSize:CGSizeMake(detailScrollContentWidth, _bottomPageDataScrollView.frame.size.height)];
    
    // 2. Adding Page Content ViewController's view as scroll view's subview
    
    int pageNo = 1;
    
    for (UIViewController *vc in _pageViewControllerArray)
    {
        /* Content page's x position calculation */
        
        // Formula: xPos = scrollViewWidth * ( pageNo -1 )
        // Where,
        // pageNo starts with 1
        
        int xPos = _bottomPageDataScrollView.frame.size.width * (pageNo -1);
        vc.view.frame = CGRectMake(xPos, 0, _bottomPageDataScrollView.frame.size.width, vc.view.frame.size.height);
        pageNo ++;
        
        [self addChildViewController:vc];
        [_bottomPageDataScrollView addSubview:vc.view];
        [vc didMoveToParentViewController:self];
    }
}


#pragma ScrollView delegate methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _topTitleScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x/2, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _topTitleScrollView.contentOffset = CGPointMake(scrollView.contentOffset.x/2, 0);
    
    CGFloat pageWidth = _bottomPageDataScrollView.frame.size.width;
    
    //Calculate page no. if 50 percent or more area of any page visible make it as current page
    _pageNo = floor((_bottomPageDataScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2;
}


@end
