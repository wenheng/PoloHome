//
//  HXTabBarController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXTabBarController.h"
#import "UIColor+HX.h"

#import "HXBaseNavigationController.h"

#import "HXHomeController.h"
#import "HXMallController.h"
#import "HXDiscoverController.h"
#import "HXMeController.h"


@interface HXTabBarController ()<UITabBarControllerDelegate,CYLTabBarControllerDelegate>

@end

@implementation HXTabBarController

#pragma mark -
#pragma mark - Init Method
- (instancetype)init
{
  if (self = [super init]) {
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;
    UIOffset titlePositionAdjustment = UIOffsetMake(0, 0);
    CYLTabBarController *tabrController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController imageInsets:imageInsets titlePositionAdjustment:titlePositionAdjustment context:nil];
    tabrController.delegate = self;
    [self customizeTabBarAppearance:tabrController];
    self = (HXTabBarController *)tabrController;
  }
  return self;
}


#pragma mark -
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}
- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark - Private Method
- (NSArray *)viewControllers
{
  HXHomeController *firstVC = [[HXHomeController alloc] init];
  HXBaseNavigationController *firstNav = [[HXBaseNavigationController alloc]
                                      initWithRootViewController:firstVC];
  HXMallController *secondVC = [[HXMallController alloc] init];
  HXBaseNavigationController *secondNav = [[HXBaseNavigationController alloc]
                                         initWithRootViewController:secondVC];
  HXDiscoverController *thirdVC = [[HXDiscoverController alloc] init];
  HXBaseNavigationController *thirdNav = [[HXBaseNavigationController alloc]
                                              initWithRootViewController:thirdVC];
  HXMeController *fourthVC = [[HXMeController alloc] init];
  HXBaseNavigationController *fourthNav = [[HXBaseNavigationController alloc]
                                          initWithRootViewController:fourthVC];
  NSArray *viewControllers = @[firstNav,secondNav,thirdNav,fourthNav];
  return viewControllers;
}



- (NSArray *)tabBarItemsAttributesForController
{
  NSMutableDictionary *firstAttr = [NSMutableDictionary dictionary];
  firstAttr[CYLTabBarItemTitle]         = @"首页";
  firstAttr[CYLTabBarItemImage]         = @"tabbar_home_normal";
  firstAttr[CYLTabBarItemSelectedImage] = @"tabbar_home_selected";
  
  NSMutableDictionary *secondAttr = [NSMutableDictionary dictionary];
  secondAttr[CYLTabBarItemTitle]         = @"商城";
  secondAttr[CYLTabBarItemImage]         = @"tabbar_journey_normal";
  secondAttr[CYLTabBarItemSelectedImage] = @"tabbar_journey_selected";
  
  NSMutableDictionary *thirdAttr = [NSMutableDictionary dictionary];
  thirdAttr[CYLTabBarItemTitle]         = @"发现";
  thirdAttr[CYLTabBarItemImage]         = @"tabbar_discover_normal";
  thirdAttr[CYLTabBarItemSelectedImage] = @"tabbar_discover_selected";
  
  NSMutableDictionary *fourthAttr = [NSMutableDictionary dictionary];
  fourthAttr[CYLTabBarItemTitle]         = @"我的";
  fourthAttr[CYLTabBarItemImage]         = @"tabbar_me_normal";
  fourthAttr[CYLTabBarItemSelectedImage] = @"tabbar_me_selected";
  
  NSArray *tabBarItemsAttributes = @[firstAttr,secondAttr,thirdAttr,fourthAttr];
  return tabBarItemsAttributes;
}


- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
  // Customize UITabBar height
  // 自定义 TabBar 高度
  //    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
  
  // set the text color for unselected state
  // 普通状态下的文字属性
  NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
  normalAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:0XACACAC];
  
  // set the text color for selected state
  // 选中状态下的文字属性
  NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
  selectedAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHex:0X41B24E];
  
  // set the text Attributes
  // 设置文字属性
  UITabBarItem *tabBar = [UITabBarItem appearance];
  [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
  [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
  
  // Set the dark color to selected tab (the dimmed background)
  // TabBarItem选中后的背景颜色
  [self customizeTabBarSelectionIndicatorImage];
  
  // update TabBar when TabBarItem width did update
  // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
  // remove the comment '//'
  // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
  [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
  
  // set the bar shadow image
  // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
  [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
  [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
  [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
  //        [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
  
  // set the bar background image
  // 设置背景图片
  UITabBar *tabBarAppearance = [UITabBar appearance];
  [UITabBar appearance].translucent = NO;
  NSString *tabBarBackgroundImageName = @"tabbarBg";
  UIImage *tabBarBackgroundImage = [UIImage imageNamed:tabBarBackgroundImageName];
  UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage];
  [tabBarAppearance setBackgroundImage:scanedTabBarBackgroundImage];
  
  // remove the bar system shadow image
  // 去除 TabBar 自带的顶部阴影
  // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
  [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate
{
  void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
      NSLog(@"Landscape Left or Right !");
    } else if (orientation == UIDeviceOrientationPortrait) {
      NSLog(@"Landscape portrait!");
    }
    [self customizeTabBarSelectionIndicatorImage];
  };
  [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                    object:nil
                                                     queue:[NSOperationQueue mainQueue]
                                                usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage
{
  ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
  CGFloat tabBarHeight = kTabBarHeight;
  CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
  //Get initialized TabBar if exists.
  UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
  [tabBar setSelectionIndicatorImage:
   [[self class] imageWithColor:[UIColor whiteColor]
                           size:selectionIndicatorImageSize]];
}

+ (UIImage *)scaleImage:(UIImage *)image
{
  CGFloat halfWidth = image.size.width/2;
  CGFloat halfHeight = image.size.height/2;
  UIImage *secondStrechImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth) resizingMode:UIImageResizingModeStretch];
  return secondStrechImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
  if (!color || size.width <= 0 || size.height <= 0) return nil;
  CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, color.CGColor);
  CGContextFillRect(context, rect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}



#pragma mark -
#pragma mark - CYLTabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
  [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
  return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control
{
  UIView *animationView;
  
  if ([control cyl_isTabButton]) {
    //更改红标状态
    if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
      [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
    } else {
      [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
    }
    animationView = [control cyl_tabImageView];
  }
  
  if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
    [self addScaleAnimationOnView:animationView repeatCount:1];
  } else {
    [self addRotateAnimationOnView:animationView];
  }
  
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
  //需要实现的帧动画，这里根据需求自定义
  CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
  animation.keyPath = @"transform.scale";
  animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
  animation.duration = 1;
  animation.repeatCount = repeatCount;
  animation.calculationMode = kCAAnimationCubic;
  [animationView.layer addAnimation:animation forKey:nil];
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
  // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
  // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
  // 动画结束后复位
  animationView.layer.zPosition = 65.f / 2;
  [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
  } completion:nil];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
      animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
    } completion:nil];
  });
}

#pragma mark -
#pragma mark - CYLTabBarControllerDelegate




@end
