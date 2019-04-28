//
//  HXNavigationController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "HXNavigationController.h"

@interface HXNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property (nonatomic, readonly) HXNavigationBar *navigationBar;

@property (nonatomic, strong) UIVisualEffectView *fromFakeBar;
@property (nonatomic, strong) UIVisualEffectView *toFakeBar;
@property (nonatomic, strong) UIImageView *fromFakeShadow;
@property (nonatomic, strong) UIImageView *toFakeShadow;
@property (nonatomic, strong) UIImageView *fromFakeImageView;
@property (nonatomic, strong) UIImageView *toFakeImageView;
@property (nonatomic, weak) UIViewController *popingViewController;

@end

@implementation HXNavigationController

@dynamic navigationBar;

#pragma mark -
#pragma mark - Life Cycle
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
  if (self = [super initWithNavigationBarClass:[HXNavigationBar class] toolbarClass:nil]) {
    self.viewControllers = @[rootViewController];
  }
  return self;
}
- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
  NSAssert([navigationBarClass isSubclassOfClass:[HXNavigationBar class]], @"navigationBarClass Must be a subclass of HXNavigationBar");
  return [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
}
- (instancetype)init
{
  return [super initWithNavigationBarClass:[HXNavigationBar class] toolbarClass:nil];
}
- (UIViewController *)childViewControllerForStatusBarHidden
{
  return self.topViewController;
}
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.interactivePopGestureRecognizer.delegate = self;
  [self.interactivePopGestureRecognizer addTarget:self action:@selector(handlePopGesture:)];
  self.delegate = self;
  self.navigationBar.translucent = YES;
  self.navigationBar.shadowImage = [UINavigationBar appearance].shadowImage;
  
}

- (void)viewWillLayoutSubviews
{
  [super viewWillLayoutSubviews];
  
  self.topViewController.view.frame = self.topViewController.view.frame;
  
  id<UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
  if (coordinator) {
    UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (from == self.popingViewController) {
      [self updateNavigationBarForViewController:from];
    }
  }
  else {
    [self updateNavigationBarForViewController:self.topViewController];
  }
}

#pragma mark -
#pragma mark - Event Method
- (void)handlePopGesture:(UIScreenEdgePanGestureRecognizer *)recognizer
{
  id <UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
  UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *to   = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey];
  if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
    self.navigationBar.tintColor = blendColor(from.hx_tintColor, to.hx_tintColor, coordinator.percentComplete);
  }
}

#pragma mark -
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  self.navigationBar.titleTextAttributes = viewController.hx_titleTextAttribute;
  self.navigationBar.barStyle            = viewController.hx_barStyle;
  
  id<UIViewControllerTransitionCoordinator> coordinator = self.transitionCoordinator;
  if (coordinator) {
    [self showViewController:viewController withCoordinator:coordinator];
  }
  else {
    if (!animated && self.childViewControllers.count > 1) {
      UIViewController *lastButOne = self.childViewControllers[self.childViewControllers.count - 2];
      if (shouldShowFake(viewController, lastButOne, viewController)) {
        [self showFakeBarFromController:lastButOne toController:viewController];
        return;
      }
    }
    [self updateNavigationBarForViewController:viewController];
  }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if (!animated) {
    [self updateNavigationBarForViewController:viewController];
    [self clearFake];
  }
  self.popingViewController = nil;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  self.popingViewController              = self.topViewController;
  UIViewController *vc                   = [super popViewControllerAnimated:animated];
  self.navigationBar.barStyle            = self.topViewController.hx_barStyle;
  self.navigationBar.titleTextAttributes = self.topViewController.hx_titleTextAttribute;
  return vc;
}

- (NSArray<UIViewController *>*)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  self.popingViewController              = self.topViewController;
  NSArray *array                         = [super popToViewController:viewController animated:animated];
  self.navigationBar.barStyle            = self.topViewController.hx_barStyle;
  self.navigationBar.titleTextAttributes = self.topViewController.hx_titleTextAttribute;
  return array;
}
- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
  self.popingViewController              = self.topViewController;
  NSArray *array                         = [super popToRootViewControllerAnimated:animated];
  self.navigationBar.barStyle            = self.topViewController.hx_barStyle;
  self.navigationBar.titleTextAttributes = self.topViewController.hx_titleTextAttribute;
  return array;
}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
  if (self.viewControllers.count > 1) {
    return self.topViewController.hx_backInteractive && self.topViewController.hx_swipeBackEnabled;
  }
  return NO;
}
#pragma mark -
#pragma mark - UINavigationBarDelegate
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
  if (self.viewControllers.count > 1 && self.topViewController.navigationItem == item) {
    if (!(self.topViewController.hx_backInteractive && self.topViewController.hx_clickBackEnabled)) {
      [self resetButtonLabelInNavigationBar:self.navigationBar];
      return NO;
    }
  }
  return [super navigationBar:navigationBar shouldPopItem:item];
}

#pragma mark -
#pragma mark - Public Method
- (void)updateNavigationBarForViewController:(UIViewController *)viewController
{
  [self updateNavigationBarAlphaForViewController:viewController];
  [self updateNavigationBarColorOrImageForViewController:viewController];
  [self updateNavigationBarShadowImageAlphaForViewController:viewController];
  [self updateNavigationBarAnimatedForViewController:viewController];
}
- (void)updateNavigationBarAlphaForViewController:(UIViewController *)viewController
{
  if (viewController.hx_computedBarImage) {
    self.navigationBar.fakeView.alpha            = 0;
    self.navigationBar.backgroundImageView.alpha = viewController.hx_barAlpha;
  }
  else {
    self.navigationBar.fakeView.alpha            = viewController.hx_barAlpha;
    self.navigationBar.backgroundImageView.alpha = 0;
  }
  self.navigationBar.shadowImageView.alpha = viewController.hx_computedBarShodowAlpha;
  
}
- (void)updateNavigationBarColorOrImageForViewController:(UIViewController *)viewController
{
  self.navigationBar.barTintColor              = viewController.hx_computedBarTintColor;
  self.navigationBar.backgroundImageView.image = viewController.hx_computedBarImage;
}
- (void)updateNavigationBarShadowImageAlphaForViewController:(UIViewController *)viewController
{
  self.navigationBar.shadowImageView.alpha = viewController.hx_computedBarShodowAlpha;
}

#pragma mark -
#pragma mark - Private Method
- (void)printSubViews:(UIView *)view prefix:(NSString *)prefix
{
  NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
  NSLog(@"%@%@", prefix, viewName);
  if (view.subviews.count > 0) {
    for (UIView *sub in view.subviews) {
      [self printSubViews:sub prefix:[NSString stringWithFormat:@"--%@",prefix]];
    }
  }
}
//修复系统bug
- (void)resetButtonLabelInNavigationBar:(UINavigationBar *)navigationBar
{
  if (@available(iOS 12.0, *)) {
    for (UIView *view in navigationBar.subviews) {
      NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
      if ([viewName isEqualToString:@"UINavigationBarContentView"]) {
        [self resetButtonLabelInView:view];
        break;
      }
    }
  }
}
- (void)resetButtonLabelInView:(UIView *)view
{
  NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
  if ([viewName isEqualToString:@"UIButtonLabel"]) {
    view.alpha = 1.0;
  }
  else if (view.subviews.count > 0) {
    for (UIView *subv in view.subviews) {
      [self resetButtonLabelInView:subv];
    }
  }
}

- (void)updateNavigationBarAnimatedForViewController:(UIViewController *)vc
{
  [UIView setAnimationsEnabled:NO];
  self.navigationBar.barStyle            = vc.hx_barStyle;
  self.navigationBar.titleTextAttributes = vc.hx_titleTextAttribute;
  self.navigationBar.tintColor           = vc.hx_tintColor;
  [UIView setAnimationsEnabled:YES];
  
}

- (void)showViewController:(UIViewController *)viewController withCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
  UIViewController *from = [coordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *to   = [coordinator viewControllerForKey:UITransitionContextToViewControllerKey];
  
  //修复系统bug
  [self resetButtonLabelInNavigationBar:self.navigationBar];
  
  [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    
    BOOL shouldFake = shouldShowFake(viewController, from, to);
    if (shouldFake) {
      [self showViewControllerAlongSideTransition:viewController from:from to:to interactive:context.interactive];
    }
    else {
      [self showViewControllerAlongSideTransition:viewController interactive:context.interactive];
    }
    
  } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
    
    if (context.isCancelled) {
      [self updateNavigationBarForViewController:from];
    }
    else {
      //当present时 to 不等于 viewController
      [self updateNavigationBarForViewController:viewController];
    }
    if (to == viewController) {
      [self clearFake];
    }
  }];
  
  if (coordinator.interactive) {
    if (@available(iOS 10.0, *)) {
      [coordinator notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if (context.isCancelled) {
          [self updateNavigationBarAnimatedForViewController:from];
        }
        else {
          [self updateNavigationBarAnimatedForViewController:viewController];
        }
      }];
    }
    else {
      [coordinator notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        if (context.isCancelled) {
          [self updateNavigationBarAnimatedForViewController:from];
        }
        else {
          [self updateNavigationBarAnimatedForViewController:viewController];
        }
      }];
    }
  }
  
}
- (void)showViewControllerAlongSideTransition:(UIViewController *)viewController interactive:(BOOL)interactive
{
  self.navigationBar.titleTextAttributes = viewController.hx_titleTextAttribute;
  self.navigationBar.barStyle            = viewController.hx_barStyle;
  if (!interactive) {
    self.navigationBar.tintColor = viewController.hx_tintColor;
  }
  
  [self updateNavigationBarAlphaForViewController:viewController];
  [self updateNavigationBarColorOrImageForViewController:viewController];
  [self updateNavigationBarShadowImageAlphaForViewController:viewController];
}

- (void)showViewControllerAlongSideTransition:(UIViewController *)viewController from:(UIViewController *)from to:(UIViewController *)to interactive:(BOOL)interactive
{
  //标题栏样式，按钮颜色 ...
  self.navigationBar.titleTextAttributes = viewController.hx_titleTextAttribute;
  self.navigationBar.barStyle            = viewController.hx_barStyle;
  if (!interactive) {
    self.navigationBar.tintColor = viewController.hx_tintColor;
  }
  //背景透明度 背景颜色 阴影透明度
  [self showFakeBarFromController:from toController:to];
}
- (void)showFakeBarFromController:(UIViewController *)from toController:(UIViewController *)to
{
  [UIView setAnimationsEnabled:NO];
  self.navigationBar.fakeView.alpha            = 0;
  self.navigationBar.shadowImageView.alpha     = 0;
  self.navigationBar.backgroundImageView.alpha = 0;
  [self showFakeBarFromController:from];
  [self showFakeBarToController:to];
  [UIView setAnimationsEnabled:YES];
}
- (void)showFakeBarFromController:(UIViewController *)from
{
  self.fromFakeImageView.image = from.hx_computedBarImage;
  self.fromFakeImageView.alpha = from.hx_barAlpha;
  self.fromFakeImageView.frame = [self fakeBarFrameForViewController:from];
  [from.view addSubview:self.fromFakeImageView];
  
  self.fromFakeBar.subviews.lastObject.backgroundColor = from.hx_computedBarTintColor;
  self.fromFakeBar.alpha = from.hx_barAlpha == 0 || from.hx_computedBarImage ? 0.01 : from.hx_barAlpha;
  if (from.hx_barAlpha == 0 || from.hx_computedBarImage) {
    self.fromFakeBar.subviews.lastObject.alpha = 0.01;
  }
  self.fromFakeBar.frame = [self fakeBarFrameForViewController:from];
  [from.view addSubview:self.fromFakeBar];
  
  self.fromFakeShadow.alpha = from.hx_computedBarShodowAlpha;
  self.fromFakeShadow.frame = [self fakeShowFrameWithBarFrame:self.fromFakeBar.frame];
  [from.view addSubview:self.fromFakeShadow];
  
}
- (void)showFakeBarToController:(UIViewController *)to
{
  self.toFakeImageView.image = to.hx_computedBarImage;
  self.toFakeImageView.alpha = to.hx_barAlpha;
  self.toFakeImageView.frame = [self fakeBarFrameForViewController:to];
  [to.view addSubview:self.toFakeImageView];
  
  self.toFakeBar.subviews.lastObject.backgroundColor = to.hx_computedBarTintColor;
  self.toFakeBar.alpha = to.hx_computedBarImage ? 0 : to.hx_barAlpha;
  self.toFakeBar.frame = [self fakeBarFrameForViewController:to];
  [to.view addSubview:self.toFakeBar];
  
  self.toFakeShadow.alpha = to.hx_computedBarShodowAlpha;
  self.toFakeShadow.frame = [self fakeShowFrameWithBarFrame:self.toFakeBar.frame];
  [to.view addSubview:self.toFakeShadow];
}


- (void)clearFake
{
  [_fromFakeBar removeFromSuperview];
  [_toFakeBar removeFromSuperview];
  [_fromFakeShadow removeFromSuperview];
  [_toFakeShadow removeFromSuperview];
  [_fromFakeImageView removeFromSuperview];
  [_toFakeImageView removeFromSuperview];
  
  _fromFakeBar       = nil;
  _toFakeBar         = nil;
  _fromFakeShadow    = nil;
  _toFakeShadow      = nil;
  _fromFakeImageView = nil;
  _toFakeImageView   = nil;
}

- (CGRect)fakeBarFrameForViewController:(UIViewController *)vc
{
  UIView *back = [self.navigationBar.subviews firstObject];
  CGRect frame = [self.navigationBar convertRect:back.frame toView:vc.view];
  frame.origin.x = vc.view.frame.origin.x;
  //解决根视图为scrollView,push不正常
  if ([vc.view isKindOfClass:[UIScrollView class]]) {
    UIScrollView *scrollView = (UIScrollView *)vc.view;
    //适配iPhone X iPhone XR
    NSArray *xrs   = @[@812,@896];
    BOOL isIphonxX = [xrs containsObject:@([UIScreen mainScreen].bounds.size.height)];
    if (scrollView.contentOffset.y == 0) {
      frame.origin.y = - (isIphonxX ? 88 : 64);
    }
  }
  return frame;
}
- (CGRect)fakeShowFrameWithBarFrame:(CGRect)frame
{
  return CGRectMake(frame.origin.x, frame.size.height + frame.origin.y - 0.5, frame.size.width, 0.5);
}

#pragma mark -
#pragma mark - Function Tool Method
BOOL shouldShowFake(UIViewController *vc, UIViewController *from, UIViewController *to) {
  if (vc != to) {
    return NO;
  }
  
  if (from.hx_computedBarImage && to.hx_computedBarImage && isImageEqual(from.hx_computedBarImage, to.hx_computedBarImage)) {
    //都有图片且是同一张图片
    if (ABS(from.hx_barAlpha - to.hx_barAlpha > 0.1)) {
      return YES;
    }
    return NO;
  }
  
  if (!from.hx_computedBarImage && !to.hx_computedBarImage && [from.hx_computedBarTintColor.description isEqualToString:to.hx_computedBarTintColor.description]) {
    //都没有图片，并且颜色相同
    if (ABS(from.hx_barAlpha - to.hx_barAlpha) > 0.1) {
      return YES;
    }
    return NO;
  }
  return YES;
}

BOOL isImageEqual(UIImage *image1, UIImage *image2)
{
  BOOL result = NO;
  if (image1 == image2) {
    result = YES;
  }
  
  if (image1 && image2) {
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    result = [data1 isEqual:data2];
  }
  return result;
}

UIColor *blendColor(UIColor *from, UIColor *to, CGFloat percent)
{
  CGFloat fromRed   = 0.0;
  CGFloat fromGreen = 0.0;
  CGFloat fromBlue  = 0.0;
  CGFloat fromAlpha = 0.0;
  [from getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
  
  CGFloat toRed   = 0.0;
  CGFloat toGreen = 0.0;
  CGFloat toBlue  = 0.0;
  CGFloat toAlpha = 0.0;
  [to getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
  
  CGFloat newRed   = fromRed + (toRed - fromRed) * fminf(1, percent * 4);
  CGFloat newGreen = fromGreen + (toGreen - fromGreen) * fminf(1, percent * 4);
  CGFloat newBlue  = fromBlue + (toBlue - fromBlue) * fminf(1, percent * 4);
  CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * fminf(1, percent * 4);
  return [UIColor colorWithRed:newRed green:newGreen blue:newBlue alpha:newAlpha];
}

#pragma mark -
#pragma mark - Getter
- (UIVisualEffectView *)fromFakeBar
{
  if (!_fromFakeBar) {
    _fromFakeBar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
  }
  return _fromFakeBar;
}

- (UIVisualEffectView *)toFakeBar
{
  if (!_toFakeBar) {
    _toFakeBar = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
  }
  return _toFakeBar;
}

- (UIImageView *)fromFakeImageView
{
  if (!_fromFakeImageView) {
    _fromFakeImageView = [[UIImageView alloc] init];
  }
  return _fromFakeImageView;
}

- (UIImageView *)toFakeImageView
{
  if (!_toFakeImageView) {
    _toFakeImageView = [[UIImageView alloc] init];
  }
  return _toFakeImageView;
}


- (UIImageView *)fromFakeShadow
{
  if (!_fromFakeShadow) {
    _fromFakeShadow = [[UIImageView alloc] initWithImage:self.navigationBar.shadowImageView.image];
    _fromFakeShadow.backgroundColor = self.navigationBar.shadowImageView.backgroundColor;
  }
  return _fromFakeShadow;
}

- (UIImageView *)toFakeShadow
{
  if (!_toFakeShadow) {
    _toFakeShadow = [[UIImageView alloc] initWithImage:self.navigationBar.shadowImageView.image];
    _toFakeShadow.backgroundColor = self.navigationBar.shadowImageView.backgroundColor;
  }
  return _toFakeShadow;
}


@end
