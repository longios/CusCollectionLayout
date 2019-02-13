//
//  NSArray+FindBouncesView.m
//  CollectionLayout
//
//  Created by Abe on 2017/9/1.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import "NSArray+FindBouncesView.h"
// 采用二分法  快速找到边界的视图
typedef NS_ENUM(NSUInteger, FindViewDirection) {
    FindViewLeft = 0,
    FindViewRight,
};
@implementation NSArray (FindBouncesView)

- (NSInteger)findRightViewWithRect:(CGRect)rect {
    if(self.count == 0) {
        return -1;
    }
//    UIView *rightView = (UIView *)[self objectAtIndex:self.count - 1];
    CGRect rightFrame = [[self objectAtIndex:self.count - 1] CGRectValue];
    if(CGRectContainsRect(rect, rightFrame)) {
        return self.count - 1; // 代表全部right都在rect范围内
    }
    NSInteger rightindex = [self findViewWithLeftIndex:0 rightIndex:self.count - 1 rect:rect direction:FindViewRight];
//    if(rightindex < self.count - 1) {
//        rightindex += 1;
//    }
    return rightindex;
    
}
- (NSInteger)findLeftViewWithRect:(CGRect)rect {
    if(self.count == 0) {
        return -1;
    }
//    UIView *leftView = (UIView *)[self objectAtIndex:0];
    CGRect leftFrame = [[self objectAtIndex:0] CGRectValue];
    if(CGRectContainsRect(rect, leftFrame)) {
        return 0; // 代表全部left都在rect范围内
    }
    NSInteger leftindex = [self findViewWithLeftIndex:0 rightIndex:self.count - 1 rect:rect direction:FindViewLeft];
//    if(leftindex > 0) {
//        leftindex -= 1;
//    }
    return leftindex;
}

- (NSInteger)findViewWithLeftIndex:(NSInteger)left rightIndex:(NSInteger)right rect:(CGRect)rect direction:(FindViewDirection)direction{
    if(left < 0 || right > self.count - 1 || CGRectIsEmpty(rect)) {
        return -1;
    }
    if(right - left <= 1) {
        CGRect rframe = [[self objectAtIndex:left] CGRectValue];
        CGRect lframe = [[self objectAtIndex:right] CGRectValue];
        BOOL containL = CGRectContainsRect(rect, lframe);
        BOOL containR = CGRectContainsRect(rect, rframe);
        if(containL && !containR) {
            return left;
        }else if(!containL && containR) {
            return right;
        }else if(!containL && !containR) {
            return -1;
        }else if(containL && containR) {
            if(direction == FindViewLeft) {
                return left;
            }else {
                return right;
            }
        }
    }
    NSInteger center = left + (right - left) / 2;
//    UIView *centerview = (UIView *)[self objectAtIndex:center];
    CGRect centerFrame = [[self objectAtIndex:center] CGRectValue];
    
    
    if(direction == FindViewRight) {
        if(CGRectContainsRect(rect, centerFrame)) {
            return [self findViewWithLeftIndex:center rightIndex:right rect:rect direction:FindViewRight];
            
        }else {
            return [self findViewWithLeftIndex:left rightIndex:center rect:rect direction:FindViewRight];
        }
    }else {
        if(CGRectContainsRect(rect, centerFrame)) {
            return [self findViewWithLeftIndex:left rightIndex:center rect:rect direction:FindViewLeft];
            
        }else {
            return [self findViewWithLeftIndex:center rightIndex:right rect:rect direction:FindViewLeft];
        }
        
    }
    
}

- (NSArray *)zlarrayAtPath:(NSString *)path {
    NSMutableArray *ary = [NSMutableArray array];
    for(id obj in self) {
        if([obj respondsToSelector:NSSelectorFromString(path)]) {
            [ary addObject:[obj valueForKeyPath:path]];
        }
    }
    return [ary copy];
}

@end
