//
//  CardScrollLayout.h
//  CollectionLayout
//
//  Created by Abe on 2017/8/31.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardScrollLayout : UICollectionViewLayout
@property (assign, nonatomic) CGSize itemSize;
@property (assign, nonatomic) CGFloat minimumInteritemSpacing;
@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) UIEdgeInsets sectionInset;

@end
