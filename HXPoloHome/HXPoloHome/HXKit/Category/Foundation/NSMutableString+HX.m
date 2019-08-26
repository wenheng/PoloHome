//
//  NSMutableString+HX.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "NSMutableString+HX.h"

@implementation NSMutableString (HX)

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color lineSpacing:(CGFloat)spacing
{
  if (!font) {
    NSAssert(0, @"请传递一个正常的字体参数");
  }
  if (!color) {
    NSAssert(0, @"请传递一个正常的字体参数");
  }
  
  if (![string isNonEmpty]) {
    return [[NSMutableAttributedString alloc] initWithString:@"" attributes:nil];
  }
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  style.lineSpacing = spacing;
  style.lineBreakMode = NSLineBreakByWordWrapping;
  NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:style}];
  return attributedString.mutableCopy;
}

@end
