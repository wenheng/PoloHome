//
//  UINavigationItem+HXFixSpace.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "UINavigationItem+HXFixSpace.h"
#import "HXNavigationConfig.h"
#import "NSObject+HXRuntime.h"

@implementation UINavigationItem (HXFixSpace)

+ (void)load
{
  if (@available(iOS 11.0, *)) {
    
  }
  else {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      NSArray <NSString *>*oriSels = @[
                                       @"setLeftBarButtonItem:",
                                       @"setLeftBarButtonItem:animated:",
                                       @"setLeftBarButtonItems:",
                                       @"setLeftBarButtonItems:animated:",
                                       @"setRightBarButtonItem:",
                                       @"setRightBarButtonItem:animated:",
                                       @"setRightBarButtonItems:",
                                       @"setRightBarButtonItems:animated:",
                                       ];
      
      [oriSels enumerateObjectsUsingBlock:^(NSString * _Nonnull oriSel, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *swiSel = [NSString stringWithFormat:@"hx_%@", oriSel];
        [self swizzleInstanceMethodWithOriginSel:NSSelectorFromString(oriSel)
                                     swizzledSel:NSSelectorFromString(swiSel)];
      }];
    });
  }
}

- (void)hx_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
  [self setLeftBarButtonItem:leftBarButtonItem animated:NO];
}

- (void)hx_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem animated:(BOOL)animated
{
  if (![HXNavigationConfig shared].hx_disableFixSpace && leftBarButtonItem) {
    [self setLeftBarButtonItems:@[leftBarButtonItem] animated:animated];
  }
  else {//不存在按钮 或者不需要调节
    [self hx_setLeftBarButtonItem:leftBarButtonItem animated:animated];
  }
}

- (void)hx_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems
{
  [self setLeftBarButtonItems:leftBarButtonItems animated:NO];
}

- (void)hx_setLeftBarButtonItems:(NSArray<UIBarButtonItem *> *)leftBarButtonItems animated:(BOOL)animated
{
  if (leftBarButtonItems.count > 0) {
    UIBarButtonItem *firstItem = leftBarButtonItems.firstObject;
    if (firstItem.width == [HXNavigationConfig shared].hx_fixedSpaceWidth) {//已经存在了space
      [self  hx_setLeftBarButtonItems:leftBarButtonItems animated:animated];
    }
    else {
      NSMutableArray *items = [NSMutableArray arrayWithArray:leftBarButtonItems];
      [items insertObject:[self fixedSpaceItemWithWidth:[HXNavigationConfig shared].hx_fixedSpaceWidth] atIndex:0];
      [self hx_setLeftBarButtonItems:items animated:animated];
    }
  }
  else {
    [self hx_setLeftBarButtonItems:leftBarButtonItems animated:animated];
  }
}

- (void)hx_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
  [self setRightBarButtonItem:rightBarButtonItem animated:NO];
}

- (void)hx_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem animated:(BOOL)animated
{
  if (![HXNavigationConfig shared].hx_disableFixSpace && rightBarButtonItem) {//存在按钮且需要调整
    [self setRightBarButtonItems:@[rightBarButtonItem] animated:animated];
  }
  else {//不存在不需要调节
    [self hx_setRightBarButtonItem:rightBarButtonItem animated:animated];
  }
}

- (void)hx_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems
{
  [self setRightBarButtonItems:rightBarButtonItems animated:NO];
}

- (void)hx_setRightBarButtonItems:(NSArray<UIBarButtonItem *> *)rightBarButtonItems animated:(BOOL)animated
{
  if (rightBarButtonItems.count > 0) {
    UIBarButtonItem *firstItem = rightBarButtonItems.firstObject;
    if (firstItem.width == [HXNavigationConfig shared].hx_fixedSpaceWidth) {//已经存在space
      [self hx_setRightBarButtonItems:rightBarButtonItems animated:animated];
    }
    else {
      NSMutableArray *items = [NSMutableArray arrayWithArray:rightBarButtonItems];
      [items insertObject:[self fixedSpaceItemWithWidth:[HXNavigationConfig shared].hx_fixedSpaceWidth] atIndex:0];
      [self hx_setRightBarButtonItems:items animated:animated];
    }
  }
  else {
    [self hx_setRightBarButtonItems:rightBarButtonItems animated:animated];
  }
}


- (UIBarButtonItem *)fixedSpaceItemWithWidth:(CGFloat)width
{
  UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
  fixedSpace.width = width;
  return fixedSpace;
}

@end
