//
//  CardScrollCollectionViewCell.m
//  CollectionLayout
//
//  Created by Abe on 2017/8/31.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import "CardScrollCollectionViewCell.h"
#import "UIColor+RandomColor.h"

@interface CardScrollCollectionViewCell ()
@property (strong, nonatomic) UILabel *cellLbl;

@end

@implementation CardScrollCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor randomColor];
        
        self.cellLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 100, 10)];
        [self.cellLbl setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:self.cellLbl];
    }
    return self;
}

- (void)setNum:(NSInteger)num {
    self.cellLbl.text = [NSString stringWithFormat:@"%ld",(long)num];
}

@end
