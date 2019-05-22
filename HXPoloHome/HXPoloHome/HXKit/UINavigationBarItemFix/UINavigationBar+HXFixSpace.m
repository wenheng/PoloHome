//
//  UINavigationBar+HXFixSpace.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "UINavigationBar+HXFixSpace.h"
#import "HXNavigationConfig.h"
#import "NSObject+HXRuntime.h"

@implementation UINavigationBar (HXFixSpace)

+ (void)load
{
  if (@available(iOS 11.0, *)) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      NSArray <NSString *> *originSels = @[@"layoutSubviews"];
      [originSels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *swiSel = [NSString stringWithFormat:@"hx_%@",obj];
        [self swizzleInstanceMethodWithOriginSel:NSSelectorFromString(obj) swizzledSel:NSSelectorFromString(swiSel)];
      }];
    });
  }
}

- (void)hx_layoutSubviews
{
  [self hx_layoutSubviews];
  if (![HXNavigationConfig shared].hx_disableFixSpace) {//需要调节
    CGFloat space = [HXNavigationConfig shared].hx_defaultFixSpace;
    for (UIView *sbvView in self.subviews) {
      if ([NSStringFromClass(sbvView.class) containsString:@"ContentView"]) {
        sbvView.layoutMargins = UIEdgeInsetsMake(0, space, 0, space);
        break;
      }
    }
  }
}

@end
