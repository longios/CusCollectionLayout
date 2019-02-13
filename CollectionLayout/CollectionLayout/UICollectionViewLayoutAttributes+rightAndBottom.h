//
//  UICollectionViewLayoutAttributes+rightAndBottom.h
//  CollectionLayout
//
//  Created by Abe on 2017/8/31.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>
// 根据left  top   bottom  right  判断attributes是否超出了 newbounds；

@interface UICollectionViewLayoutAttributes (rightAndBottom)
@property (assign, nonatomic) CGFloat left;
@property (assign, nonatomic) CGFloat right;
@property (assign, nonatomic) CGFloat top;
@property (assign, nonatomic) CGFloat bottom;

@end
