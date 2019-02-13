//
//  UIColor+RandomColor.m
//  CollectionLayout
//
//  Created by Abe on 2017/8/31.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (UIColor *)randomColor {
    int redvalue = arc4random() % 255;
    int greenValue = arc4random() % 255;
    int blueValue = arc4random() % 255;
    return [UIColor colorWithRed:redvalue / 255.0 green:greenValue / 255.0 blue:blueValue / 255.0 alpha:1];
}

@end
