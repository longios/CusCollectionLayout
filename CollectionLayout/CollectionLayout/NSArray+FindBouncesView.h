//
//  NSArray+FindBouncesView.h
//  CollectionLayout
//
//  Created by Abe on 2017/9/1.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSArray (FindBouncesView)

- (NSArray *)zlarrayAtPath:(NSString *)path;

- (NSInteger)findRightViewWithRect:(CGRect)rect;
- (NSInteger)findLeftViewWithRect:(CGRect)rect;

@end
