//
//  NSMutableString+HX.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+HX.h"

@interface NSMutableString (HX)

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string
                                                     font:(UIFont *)font
                                                    color:(UIColor *)color
                                              lineSpacing:(CGFloat)spacing;


@end

