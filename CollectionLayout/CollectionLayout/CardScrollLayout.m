//
//  CardScrollLayout.m
//  CollectionLayout
//
//  Created by Abe on 2017/8/31.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import "CardScrollLayout.h"
#import "NSArray+FindBouncesView.h"

@interface CardScrollLayout ()
@property (strong, nonatomic) NSMutableArray *attrs;
@property (assign, nonatomic) CGFloat totalWidth;
@property (assign, nonatomic) CGFloat totalHeight;


@end

@implementation CardScrollLayout

- (instancetype)init {
    if(self = [super init]) {
        self.itemSize = CGSizeMake(200, 80);
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 10;
       
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateFast;
    CGFloat insertoffset = (self.collectionView.frame.size.width - self.itemSize.width) / 2;
    self.sectionInset = UIEdgeInsetsMake(0, insertoffset, 0, insertoffset);

    self.totalWidth = 0;
    [self.attrs removeAllObjects];
    for (int i=0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [self.attrs addObject:attribute];
    }
    self.totalWidth += self.sectionInset.right;
    self.totalHeight += self.sectionInset.bottom;
    
    
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    if(self.collectionView.frame.size.width == 0) {
        return CGPointZero;
    }
    CGRect rect;
    rect.origin.x = proposedContentOffset.x;
    rect.origin.y = 0;
    rect.size = self.collectionView.frame.size;
    
    NSArray * array = self.attrs;
    
    // 计算CollectionView最中心点的x值 这里要求 最终的 要考虑惯性
    CGFloat centerX = self.collectionView.frame.size.width /2+ proposedContentOffset.x;
    //存放的最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
            minDelta=attrs.center.x-centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x+=minDelta;
    //如果返回的时zero 那个滑动停止后 就会立刻回到原地
    
    return proposedContentOffset;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.totalWidth, self.totalHeight);
    
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //TODO: 优化 寻找合适的arr
    
   
    NSArray *frames = [self.attrs zlarrayAtPath:@"frame"];
    NSInteger left = [frames findLeftViewWithRect:rect];
    NSInteger right = [frames findRightViewWithRect:rect];
    NSLog(@"left index %ld    right index %ld",(long)left, (long)right);
    NSArray *array = self.attrs;
    if(left != -1 && right != -1) {
         array = [self.attrs subarrayWithRange:NSMakeRange(left, right - left + 1)];
    }
   
    
    
    if(self.collectionView.frame.size.width == 0) {
        return nil;
    }
//    NSArray *array = self.attrs;
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width / 2;
    for(UICollectionViewLayoutAttributes *attributes in array) {
        CGFloat delta =ABS(attributes.center.x - centerX) / self.collectionView.frame.size.width / 2;
        attributes.alpha = 1 - delta;
        delta = delta > 0.2 ? 0.2 : delta;
        CGFloat scale = 1 - delta;
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    CGFloat x =  index*(self.itemSize.width + self.minimumInteritemSpacing) + self.sectionInset.left;
    CGFloat y = self.minimumLineSpacing + self.sectionInset.top;
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attr.frame = CGRectMake(x, y, self.itemSize.width, self.itemSize.height);
    self.totalWidth = self.totalWidth > (x + self.itemSize.width) ? self.totalWidth : (x + self.itemSize.width);
    self.totalHeight = self.totalHeight > (y + self.itemSize.height) ? self.totalHeight : (y + self.itemSize.height);
    return attr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSMutableArray *)attrs {
    if(!_attrs) {
        _attrs = [NSMutableArray array];
    }
    return _attrs;
}

@end
