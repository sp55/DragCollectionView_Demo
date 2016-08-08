
//
//  DragCollectionViewCell.m
//  DragCollectionView_Demo
//
//  Created by admin on 16/8/8.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "DragCollectionViewCell.h"


@interface DragCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation DragCollectionViewCell

- (UIImageView *)imgView{
    
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
    }
    return _imgView;
}

- (void)setImage:(UIImage *)image{
    
    _image = image;
    
    self.imgView.image = image;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self addSubview:self.imgView];
    self.imgView.frame = self.bounds;
}


@end
