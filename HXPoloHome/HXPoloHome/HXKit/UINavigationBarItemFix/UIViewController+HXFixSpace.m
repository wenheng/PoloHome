//
//  UIViewController+HXFixSpace.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "UIViewController+HXFixSpace.h"
#import "HXNavigationConfig.h"
#import "NSObject+HXRuntime.h"
#import <UIKit/UIImagePickerController.h>

static BOOL hx_tempDisableFixSpace = NO;

@implementation UIViewController (HXFixSpace)

+ (void)load
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSArray <NSString *> *oriSels = @[
                                      @"viewWillAppear:",
                                      @"viewWillDisappear:"];
    [oriSels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      NSString *swiSel = [NSString stringWithFormat:@"hx_%@",obj];
      [self swizzleInstanceMethodWithOriginSel:NSSelectorFromString(obj) swizzledSel:NSSelectorFromString(swiSel)];
    }];
  });
}

- (void)hx_viewWillAppear:(BOOL)animated
{
  if ([self isKindOfClass:[UIImagePickerController class]]) {
    hx_tempDisableFixSpace = [HXNavigationConfig shared].hx_disableFixSpace;
    [HXNavigationConfig shared].hx_disableFixSpace = YES;
  }
  [self hx_viewWillAppear:animated];
  if (@available(iOS 11.0, *)) {
    if (!animated && self.navigationController) {
      [self.navigationController.navigationBar layoutSubviews];
    }
  }
}

- (void)hx_viewWillDisappear:(BOOL)animated
{
  if ([self isKindOfClass:[UIImagePickerController class]]) {
    [HXNavigationConfig shared].hx_disableFixSpace = hx_tempDisableFixSpace;
  }
  [self hx_viewWillDisappear:animated];
}

@end
