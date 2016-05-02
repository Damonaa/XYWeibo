//
//  XYFeatureViewController.m
//  XYWeiBoThird
//
//  Created by 李小亚 on 16/4/25.
//  Copyright © 2016年 李小亚. All rights reserved.
//

#import "XYFeatureViewController.h"
#import "XYNewFeatureCell.h"

@interface XYFeatureViewController ()
/**
 *  页码
 */
@property (nonatomic, weak) UIPageControl *padgeCtr;

@end

@implementation XYFeatureViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Register cell classes
    [self.collectionView registerClass:[XYNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self setupPadgeCtr];
}

- (void)setupPadgeCtr{
    UIPageControl *padgeCtr = [[UIPageControl alloc] init];
    self.padgeCtr = padgeCtr;
    [self.view addSubview:padgeCtr];
    padgeCtr.numberOfPages = 4;
    padgeCtr.pageIndicatorTintColor = [UIColor lightGrayColor];
    padgeCtr.currentPageIndicatorTintColor = [UIColor orangeColor];
    
    padgeCtr.center = CGPointMake(XYScreenWidth / 2, XYScreenHeight * 0.94);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = (scrollView.contentOffset.x + XYScreenWidth / 2) / XYScreenWidth;
    self.padgeCtr.currentPage = index;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
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
