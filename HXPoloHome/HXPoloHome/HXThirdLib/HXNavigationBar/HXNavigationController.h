//
//  HXNavigationController.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXNavigationBar.h"
#import "UIViewController+HXNavigationBar.h"

@interface HXNavigationController : UINavigationController

- (void)updateNavigationBarForViewController:(UIViewController *)viewController;
- (void)updateNavigationBarAlphaForViewController:(UIViewController *)viewController;
- (void)updateNavigationBarColorOrImageForViewController:(UIViewController *)viewController;
- (void)updateNavigationBarShadowImageAlphaForViewController:(UIViewController *)viewController;

@end

@interface UINavigationController (UINavigationBar)<UINavigationBarDelegate>

@end

