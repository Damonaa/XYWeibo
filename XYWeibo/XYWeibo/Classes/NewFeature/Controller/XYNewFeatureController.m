//
//  XYNewFeatureController.m
//  Weibo
//
//  Created by 李小亚 on 16/3/19.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYNewFeatureController.h"
#import "XYNewFeatureCell.h"

@interface XYNewFeatureController ()

@property (nonatomic, weak) UIPageControl *padgeControl;
@end

@implementation XYNewFeatureController

static NSString * const reuseIdentifier = @"newFeatureCell";

- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //cell的大小，间距，滚动方向
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //注册cell
    [self.collectionView registerClass:[XYNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    //设置页码切换
    [self setupPadgeControl];
}
//设置页码切换
- (void)setupPadgeControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.padgeControl = pageControl;
    //页码数，页码颜色
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    //位置
    pageControl.center = CGPointMake(self.view.width / 2, self.view.height - 15);
    [self.view addSubview:pageControl];
}

#pragma mark - UIScrollViewDelegate
//更新页码，切换
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger currentIndex = (self.view.width / 2 + scrollView.contentOffset.x) / self.view.width;

    self.padgeControl.currentPage = currentIndex;
}
#pragma mark - collection view dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    
    [cell setIndexPath:indexPath count:4];
    return cell;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}
@end
