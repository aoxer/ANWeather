//
//  ANNewFeatureViewController.m
//  大安微博
//
//  Created by a on 15/11/1.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//
#define ANNewFeatureImgCount 4
#import "ANNewFeatureViewController.h"
#import "ViewController.h"
#import "ANLeftTableViewController.h"
#import "ANRightTableViewController.h"

@interface ANNewFeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)UIPageControl *pageControl;

@end

@implementation ANNewFeatureViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 创建一个scrollView: 显示所有图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];

    // 2.添加图片到scrollView
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    
    for (int i = 0; i < ANNewFeatureImgCount; i++) {
        
        NSString *imgName = [NSString stringWithFormat:@"%d.jpg", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = i * imageView.width;
        
        [scrollView addSubview:imageView];
        
        // 如果是最后一个imageView, 加按钮
        if (i == ANNewFeatureImgCount - 1) {
            [self setupLastImageView:imageView];
        }
    }

    // 3. 设置scrollView的其他属性
    // 如果想要某个方向上不能滚动, 那么这个方向上对应的尺寸传0 即可
    scrollView.contentSize = CGSizeMake(scrollW * ANNewFeatureImgCount, 0);
    scrollView.bounces = NO; // 去除弹簧效果
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // 4.添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = ANNewFeatureImgCount;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    self.pageControl = pageControl;
    // UIPageControl就算没有设置尺寸, 里面的内容还是能正常显示
//    pageControl.height = 50;
//    pageControl.width = 100;
//    pageControl.userInteractionEnabled = NO;
    
    [self.view addSubview:pageControl];
    
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互
    imageView.userInteractionEnabled = YES;
    
    // 1.设置checkBox
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    shareBtn.userInteractionEnabled = YES;
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    // 设置位置
    shareBtn.width = 200;
    shareBtn.height = 50;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.67;
    
    // 监听点击
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:shareBtn];
    
//    shareBtn.backgroundColor = ANRandomColor;
//    shareBtn.titleLabel.backgroundColor = ANRandomColor;
//    shareBtn.imageView.backgroundColor = ANRandomColor;
    
//   (内边距离 保护距离不许动的距离) 会影响内部所有控件
//    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 110, 0, 0 );
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    
    // 2.添加进入按钮
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateHighlighted];
    
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    
    // 监听点击
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:startBtn];
}

- (void)shareBtnClick:(UIButton *)shareBtn
{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startBtnClick
{
   UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [self sideMenuViewController];
}


- (RESideMenu *)sideMenuViewController
{
    ViewController *viewController = [[ViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    ANLeftTableViewController *leftTableViewController = [[ANLeftTableViewController alloc] init];
    ANRightTableViewController *rightTableViewController = [[ANRightTableViewController alloc] init];
    //    rightTableViewController.delegate = viewController;
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftTableViewController
                                                                   rightMenuViewController:rightTableViewController];
    
    
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"clear_blur"];
    sideMenuViewController.menuPreferredStatusBarStyle = 0; // UIStatusBarStyleLightContent
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    sideMenuViewController.contentViewScaleValue = 1.0;
    
    return sideMenuViewController;
}

@end




















