//
//  DragCollectionViewController.m
//  DragCollectionView_Demo
//
//  Created by admin on 16/8/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "DragCollectionViewController.h"
#import "DragCollectionViewCell.h"


#define imageCount 20



@interface DragCollectionViewController ()
@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, strong) UICollectionViewCell *currentCell;

@end

@implementation DragCollectionViewController


static NSString * const reuseIdentifier = @"DragCell";

- (instancetype)init{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        self.collectionView.pagingEnabled = YES;
        self.offsetY = 0;
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[DragCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return imageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    NSString *str = [NSString stringWithFormat:@"%zd",indexPath.item + 1];
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"jpg"];
    cell.image = [UIImage imageWithContentsOfFile:path];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获取到当前cell
    int offset = scrollView.contentOffset.y / [UIScreen mainScreen].bounds.size.height ;
    NSIndexPath *index = [NSIndexPath indexPathForItem:offset inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:index];
    
    //获取到下一个cell
    NSIndexPath *nextIndex = [NSIndexPath indexPathForItem:offset + 1 inSection:0];
    UICollectionViewCell *nextCell = [self.collectionView cellForItemAtIndexPath:nextIndex];
    
    //将下一个cell插入到当前cell的下方
    CGRect rect = nextCell.frame;
    rect.origin.y = scrollView.contentOffset.y;
    nextCell.frame = rect;
    
    [self.collectionView insertSubview:nextCell belowSubview:cell];
    
    //下拉设置透明度
    if (scrollView.contentOffset.y < self.offsetY) {
        
        CGFloat progress = (self.offsetY - scrollView.contentOffset.y) / [UIScreen mainScreen].bounds.size.height;
        cell.alpha = progress;
        
        self.currentCell = nil;
        self.currentCell = cell;
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.offsetY = scrollView.contentOffset.y;
    self.currentCell.alpha = 1.0;
    
}


@end
