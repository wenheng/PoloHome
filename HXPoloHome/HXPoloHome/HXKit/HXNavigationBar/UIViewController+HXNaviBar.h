//
//  UIViewController+HXNaviBar.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIViewController (HXNaviBar)

@property (nonatomic, assign) UIBarStyle  hx_barStyle;
@property (nonatomic, strong) UIImage *hx_barImage;
@property (nonatomic, strong) UIColor *hx_barTintColor;
@property (nonatomic, strong) UIColor *hx_tintColor;
@property (nonatomic, strong) NSDictionary *hx_titleTextAttribute;

@property (nonatomic, assign) BOOL  hx_blackBarStyle;
@property (nonatomic, assign) CGFloat  hx_barAlpha;
@property (nonatomic, assign) BOOL  hx_barHidden;
@property (nonatomic, assign) BOOL  hx_barShadowHidden;
@property (nonatomic, assign) BOOL  hx_backInteractive;
@property (nonatomic, assign) BOOL  hx_swipeBackEnabled;
@property (nonatomic, assign) BOOL  hx_clickBackEnabled;

@property (nonatomic, assign, readonly) CGFloat  hx_computedBarShodowAlpha;
@property (nonatomic, strong, readonly) UIColor *hx_computedBarTintColor;
@property (nonatomic, strong, readonly) UIImage *hx_computedBarImage;


- (void)hx_updateNavigationBar;
- (void)hx_updateNavigationBarAlpha;
- (void)hx_updateNavigationBarColorOrImage;
- (void)hx_updateNavigationBarShadowAlpha;

@end

