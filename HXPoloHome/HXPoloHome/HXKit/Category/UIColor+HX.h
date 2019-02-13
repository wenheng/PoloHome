//
//  UIColor+HX.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (HX)

/** 生成随机颜色 */
+ (UIColor *)randomColor;

/** 生成渐变色 */
+ (UIColor *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor withHeight:(NSInteger)height;

/** 由16进制颜色格式生成UIColor */
+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

/** 由16进制颜色字符串格式生成UIColor */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

/** 生成当前颜色的16进制字符串 */
- (NSString *)HEXString;

/** 通过红绿蓝色值生成UIColor */
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
