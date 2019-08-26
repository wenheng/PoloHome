//
//  NSString+HX.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "NSString+HX.h"

@implementation NSString (HX)

- (BOOL)isValidPhoneNumber
{
  NSString *regx    = @"^(13|15|17|18|14)\\d{9}$";
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
  BOOL isMatch      = [pred evaluateWithObject:self];
  return isMatch;
}

- (BOOL)isValidEmail
{
  NSString *regx    = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
  BOOL isMatch      = [pred evaluateWithObject:self];
  return isMatch;
}

- (BOOL)isValidUrl
{
  NSString *regx    = @"[a-zA-z]+://[^\\s]*";
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
  BOOL isMatch      = [pred evaluateWithObject:self];
  return isMatch;
}

- (BOOL)isBeginWithChar:(NSString *)cString
{
  return ([self hasPrefix:cString]) ? YES : NO;
}

- (BOOL)isEndWithChar:(NSString *)cString
{
  return ([self hasSuffix:cString]) ? YES : NO;
}

- (BOOL)isContainsChar:(NSString *)cString
{
  return ([self rangeOfString:cString].location == NSNotFound) ? NO : YES;
}

- (NSString *)replaceOldString:(NSString *)oldString
                 withNewString:(NSString *)newString
{
  return [self stringByReplacingOccurrencesOfString:oldString withString:newString];
}

- (NSString *)getSubStringFrom:(NSInteger)begin
                            to:(NSInteger)end
{
  NSRange range;
  range.location = begin;
  range.length   = end - begin;
  return [self substringWithRange:range];
}

- (NSString *)addString:(NSString *)string
{
  if (string.length == 0) {
    return self;
  }
  return [self stringByAppendingString:string];
}

- (NSString *)removeString:(NSString *)string
{
  if ([self containsString:string]) {
    NSRange range = [self rangeOfString:string];
    return [self stringByReplacingCharactersInRange:range withString:@""];
  }
  return self;
}

- (NSString *)trimSpace
{
  NSString *trimStr = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  return trimStr;
}

- (BOOL)isOnlyLetter
{
  NSString *regx    = @"^[A-Za-z]+$";
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
  BOOL isMatch      = [pred evaluateWithObject:self];
  return isMatch;
}

- (BOOL)isOnlyNumber
{
  NSString *regx    = @"^-?\\d+.?\\d?";
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
  BOOL isMatch      = [pred evaluateWithObject:self];
  return isMatch;
}

- (BOOL)isPassword
{
  NSString *regx    = @"^[A-Za-z0-9_]{6,18}$";
  NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regx];
  BOOL isMatch      = [pred evaluateWithObject:self];
  return isMatch;
}

- (BOOL)isInThiArray:(NSArray *)array
{
  for (NSString *str in array) {
    if ([self isEqualToString:str]) {
      return YES;
    }
  }
  return NO;
}

- (NSData *)convertToData
{
  return [self dataUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)getStringFromData:(NSData *)data
{
  return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (CGSize)attrStrSizeWithFont:(UIFont *)font
                      maxSize:(CGSize)maxSize
                    lineSpace:(CGFloat)lineSpace
{
  NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
  paraStyle.lineSpacing = lineSpace;
  paraStyle.lineBreakMode = NSLineBreakByWordWrapping;//换行模式为单词模式
  NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
  attrDict[NSFontAttributeName] = font;
  attrDict[NSParagraphStyleAttributeName] = paraStyle;
  CGSize resultSize = [self boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
  return CGSizeMake(ceil(resultSize.width), ceil(resultSize.height));
}

- (BOOL)isNonEmpty
{
  NSMutableCharacterSet *emptyStringSet = [[NSMutableCharacterSet alloc] init];
  [emptyStringSet formUnionWithCharacterSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  [emptyStringSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
  if (self.length == 0) {
    return NO;
  }
  NSString *str = [self stringByTrimmingCharactersInSet:emptyStringSet];
  return str.length > 0;
}

@end
