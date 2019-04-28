//
//  UIBarButtonItem+HXCreate.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "UIBarButtonItem+HXCreate.h"

@implementation UIBarButtonItem (HXCreate)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image
{
  return [self itemWithTarget:target action:action normalImage:image highLightedImage:nil imageEdgeInsets:UIEdgeInsetsZero];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
{
  return [self itemWithTarget:target action:action normalImage:image highLightedImage:nil imageEdgeInsets:imageEdgeInsets];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                        normalImage:(UIImage *)normalImage
                   highLightedImage:(UIImage *)highLightedImage
                    imageEdgeInsets:(UIEdgeInsets)imageEdgeInsets
{
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  [button setImage:[normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
  if (highLightedImage) {
    [button setImage:highLightedImage forState:UIControlStateHighlighted];
  }
  [button sizeToFit];
  if (button.bounds.size.width < 40) {
    CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
    button.bounds  = CGRectMake(0, 0, width, 40);
  }
  if (button.bounds.size.height > 40) {
    CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
    button.bounds  = CGRectMake(0, 0, 40, height);
  }
  button.imageEdgeInsets = imageEdgeInsets;
  return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title
{
  return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highLightedColor:nil titleEdgeInsets:UIEdgeInsetsZero];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
{
  return [self itemWithTarget:target action:action title:title font:nil titleColor:nil highLightedColor:nil titleEdgeInsets:titleEdgeInsets];
}

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             action:(SEL)action
                              title:(NSString *)title
                               font:(UIFont *)font
                         titleColor:(UIColor *)titleColor
                   highLightedColor:(UIColor *)highLightedColor
                    titleEdgeInsets:(UIEdgeInsets)titleEdgeInsets
{
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
  [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  [button setTitle:title forState:UIControlStateNormal];
  button.titleLabel.font = font?font:nil;
  [button setTitleColor:titleColor?titleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [button setTitleColor:highLightedColor ? highLightedColor:nil forState:UIControlStateHighlighted];
  [button sizeToFit];
  if (button.bounds.size.width < 40) {
    CGFloat width = 40 / button.bounds.size.height * button.bounds.size.width;
    button.bounds = CGRectMake(0, 0, width, 40);
  }
  if (button.bounds.size.height > 40) {
    CGFloat height = 40 / button.bounds.size.width * button.bounds.size.height;
    button.bounds = CGRectMake(0, 0, 40, height);
  }
  button.titleEdgeInsets = titleEdgeInsets;
  return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)fixedItemSpaceWithWidth:(CGFloat)width
{
  UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  fixedSpace.width = width;
  return fixedSpace;
}

@end
