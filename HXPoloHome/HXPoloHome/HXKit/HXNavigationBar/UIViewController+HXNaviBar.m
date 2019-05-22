//
//  UIViewController+HXNaviBar.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "UIViewController+HXNaviBar.h"
#import <objc/runtime.h>
#import "HXNavigationController.h"

@implementation UIViewController (HXNaviBar)

#pragma mark -
#pragma mark - Public Method
- (void)hx_updateNavigationBar
{
  if (self.navigationController && [self.navigationController isKindOfClass:[HXNavigationController class]]) {
    HXNavigationController *nav = (HXNavigationController *)self.navigationController;
    [nav updateNavigationBarForViewController:self];
  }
}
- (void)hx_updateNavigationBarAlpha
{
  if (self.navigationController && [self.navigationController isKindOfClass:[HXNavigationController class]]) {
    HXNavigationController *nav = (HXNavigationController *)self.navigationController;
    [nav updateNavigationBarAlphaForViewController:self];
  }
}
- (void)hx_updateNavigationBarColorOrImage
{
  if (self.navigationController && [self.navigationController isKindOfClass:[HXNavigationController class]]) {
    HXNavigationController *nav = (HXNavigationController *)self.navigationController;
    [nav updateNavigationBarColorOrImageForViewController:self];
  }
}
- (void)hx_updateNavigationBarShadowAlpha
{
  if (self.navigationController && [self.navigationController isKindOfClass:[HXNavigationController class]]) {
    HXNavigationController *nav = (HXNavigationController *)self.navigationController;
    [nav updateNavigationBarShadowImageAlphaForViewController:self];
  }
}

#pragma mark -
#pragma mark - Getter & Setter
- (BOOL)hx_blackBarStyle
{
  return self.hx_barStyle == UIBarStyleBlack;
}
- (void)setHx_blackBarStyle:(BOOL)hx_blackBarStyle
{
  self.hx_barStyle = hx_blackBarStyle ? UIBarStyleBlack : UIBarStyleDefault;
}

- (UIBarStyle)hx_barStyle
{
  id obj = objc_getAssociatedObject(self, _cmd);
  if (obj) {
    return [obj integerValue];
  }
  return [UINavigationBar appearance].barStyle;
}
- (void)setHx_barStyle:(UIBarStyle)hx_barStyle
{
  objc_setAssociatedObject(self, @selector(hx_barStyle), @(hx_barStyle), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (UIColor *)hx_barTintColor
{
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setHx_barTintColor:(UIColor *)hx_barTintColor
{
  objc_setAssociatedObject(self, @selector(hx_barTintColor), hx_barTintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)hx_barImage
{
  return objc_getAssociatedObject(self, _cmd);
}
- (void)setHx_barImage:(UIImage *)hx_barImage
{
  objc_setAssociatedObject(self, @selector(hx_barImage), hx_barImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIColor *)hx_tintColor
{
  id obj = objc_getAssociatedObject(self, _cmd);
  return obj ? obj : [UINavigationBar appearance].tintColor;
}
- (void)setHx_tintColor:(UIColor *)hx_tintColor
{
  objc_setAssociatedObject(self, @selector(hx_tintColor), hx_tintColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)hx_titleTextAttribute
{
  id obj = objc_getAssociatedObject(self, _cmd);
  return obj ? obj : [UINavigationBar appearance].titleTextAttributes;
}
- (void)setHx_titleTextAttribute:(NSDictionary *)hx_titleTextAttribute
{
  objc_setAssociatedObject(self, @selector(hx_titleTextAttribute), hx_titleTextAttribute, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGFloat)hx_barAlpha
{
  id obj = objc_getAssociatedObject(self, _cmd);
  if (self.hx_barHidden) {
    return 0;
  }
  return obj ? [obj floatValue] : 1.0f;
}
- (void)setHx_barAlpha:(CGFloat)hx_barAlpha
{
  objc_setAssociatedObject(self, @selector(hx_barAlpha), @(hx_barAlpha), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)hx_barHidden
{
  id obj = objc_getAssociatedObject(self, _cmd);
  return obj ? [obj boolValue] : NO;
}
- (void)setHx_barHidden:(BOOL)hx_barHidden
{
  if (hx_barHidden) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    self.navigationItem.titleView         = [UIView new];
  }
  else {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.titleView         = nil;
  }
  objc_setAssociatedObject(self, @selector(hx_barHidden), @(hx_barHidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)hx_barShadowHidden
{
  id obj = objc_getAssociatedObject(self, _cmd);
  return self.hx_barHidden || obj ? [obj boolValue] : NO;
}
- (void)setHx_barShadowHidden:(BOOL)hx_barShadowHidden
{
  objc_setAssociatedObject(self, @selector(hx_barShadowHidden), @(hx_barShadowHidden), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)hx_backInteractive
{
  id obj = objc_getAssociatedObject(self, _cmd);
  return obj ? [obj boolValue] : YES;
}
- (void)setHx_backInteractive:(BOOL)hx_backInteractive
{
  objc_setAssociatedObject(self, @selector(hx_backInteractive), @(hx_backInteractive), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)hx_swipeBackEnabled
{
  id obj = objc_getAssociatedObject(self, _cmd);
  return obj ? [obj boolValue] : YES;
}
- (void)setHx_swipeBackEnabled:(BOOL)hx_swipeBackEnabled
{
  objc_setAssociatedObject(self, @selector(hx_swipeBackEnabled), @(hx_swipeBackEnabled), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)hx_clickBackEnabled
{
  id obj = objc_getAssociatedObject(self, _cmd);
  return obj ? [obj boolValue] : YES;
}
- (void)setHx_clickBackEnabled:(BOOL)hx_clickBackEnabled
{
  objc_setAssociatedObject(self, @selector(hx_clickBackEnabled), @(hx_clickBackEnabled), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (CGFloat)hx_computedBarShodowAlpha
{
  return self.hx_barShadowHidden ? 0 : self.hx_barAlpha;
}
- (UIImage *)hx_computedBarImage
{
  UIImage *image = self.hx_barImage;
  if (!image) {
    if (self.hx_barTintColor) {
      return nil;
    }
    return [[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault];
  }
  return image;
}
- (UIColor *)hx_computedBarTintColor
{
  if (self.hx_barImage) {
    return nil;
  }
  UIColor *color = self.hx_barTintColor;
  if (!color) {
    if ([[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault]) {
      return nil;
    }
    
    if ([UINavigationBar appearance].barTintColor) {
      color = [UINavigationBar appearance].barTintColor;
    }
    else {
      color = [UINavigationBar appearance].barStyle == UIBarStyleDefault ? [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:0.8] : [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:0.729];
    }
  }
  return color;
}


@end
