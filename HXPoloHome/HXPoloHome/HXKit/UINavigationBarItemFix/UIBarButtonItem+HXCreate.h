//
//  UIBarButtonItem+HXCreate.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (HXCreate)


/**
 根据图片生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param image 图片
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image;


/**
 根据图片生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param image 图片
 @param imageEdgeInsets 图片偏移
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              image:(UIImage *)image
                    imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;



/**
 根据图片生成的UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param normalImage 普通状态图片
 @param highLightedImage 高亮状态图片
 @param imageEdgeInsets 图片偏移量
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                        normalImage:(UIImage *)normalImage
                     highLightedImage:(UIImage *)highLightedImage
                    imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets;


/**
 根据文字生成UIBarButtonItem

 @param target target对象
 @param action 响应方法
 @param title 文字
 @return 生成的UIBarButtonItem对象
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title;

/**
 根据文字生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param title 文字
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                    titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;

/**
 根据文字生成UIBarButtonItem
 
 @param target target对象
 @param action 响应方法
 @param title 文字
 @param font font
 @param titleColor 字体颜色
 @param highLightedColor 高亮颜色
 @param titleEdgeInsets 文字偏移
 @return 生成的UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target
                            action:(SEL)action
                             title:(NSString *)title
                              font:(UIFont *)font
                        titleColor:(UIColor *)titleColor
                  highLightedColor:(UIColor *)highLightedColor
                   titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets;


/**
 用作修正位置的UIBarButtonItem

 @param width 修正宽度
 @return 修正位置的UIBarButtonItem
 */
+ (UIBarButtonItem *)fixedItemSpaceWithWidth:(CGFloat)width;


@end

NS_ASSUME_NONNULL_END
