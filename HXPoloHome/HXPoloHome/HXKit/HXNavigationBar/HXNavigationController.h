//
//  HXNavigationController.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXNavigationBar.h"
#import "UIViewController+HXNaviBar.h"

@interface HXNavigationController : UINavigationController

- (void)updateNavigationBarForViewController:(UIViewController *)viewController;
- (void)updateNavigationBarAlphaForViewController:(UIViewController *)viewController;
- (void)updateNavigationBarColorOrImageForViewController:(UIViewController *)viewController;
- (void)updateNavigationBarShadowImageAlphaForViewController:(UIViewController *)viewController;

@end


@interface UINavigationController (UINavigationBar)<UINavigationBarDelegate>

@end
