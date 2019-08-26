//
//  NSString+HX.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HX)

/** 正则匹配手机号码 */
- (BOOL)isValidPhoneNumber;
/** 正则匹配邮箱 */
- (BOOL)isValidEmail;
/** 正则匹配URL */
- (BOOL)isValidUrl;
/** 判断是否以某个字符开头 */
- (BOOL)isBeginWithChar:(NSString *)cString;
/** 判断是否以某个字符结尾 */
- (BOOL)isEndWithChar:(NSString *)cString;
/** 判断是否包含某个字符 */
- (BOOL)isContainsChar:(NSString *)cString;
/** 新字符替换老字符 */
- (NSString *)replaceOldString:(NSString *)oldString
                 withNewString:(NSString *)newString;
/** 截取字符串 */
- (NSString *)getSubStringFrom:(NSInteger)begin
                            to:(NSInteger)end;
/** 添加字符串 */
- (NSString *)addString:(NSString *)string;
/** 移除字符串 */
- (NSString *)removeString:(NSString *)string;
/** 移除空格 */
- (NSString *)trimSpace;
/** 是否只包含字母 */
- (BOOL)isOnlyLetter;
/** 是否只包含数字 */
- (BOOL)isOnlyNumber;
/** 由字母或数字组成6-18位密码字符串 */
- (BOOL)isPassword;
/** 判断数组中是否包含某个字符串 */
- (BOOL)isInThiArray:(NSArray *)array;
/** 字符串转NSData */
- (NSData *)convertToData;
/** NSData转字符串 */
+ (NSString *)getStringFromData:(NSData *)data;
/** 计算文本占用的宽高 */
- (CGSize)attrStrSizeWithFont:(UIFont *)font
                      maxSize:(CGSize)maxSize
                    lineSpace:(CGFloat)lineSpace;
- (BOOL)isNonEmpty;

@end

