//
//  HXRouterManager.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/7/30.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXRouterManager.h"
#import <objc/runtime.h>

@interface HXRouterManager ()

@property (nonatomic, strong) HXRouterRegister *registerHelper;
@property (nonatomic, assign) HXPage  currentPage;

@end

@implementation HXRouterManager

static HXRouterManager *routerManager = nil;


#pragma mark - 线程不安全的单例
//+ (instancetype)sharedInstance
//{
//  static dispatch_once_t onceToken;
//  dispatch_once(&onceToken, ^{
//    routerManager = [[HXRouterManager alloc] init];
//  });
//  return routerManager;
//}

////重写alloc方法 或者底层allocWithZone
//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//  if (routerManager == nil) {
//    routerManager = [super allocWithZone:zone];
//  }
//  return routerManager;
//}
////当copy当前类型的对象时候 ，返回唯一的单例对象
//- (id)copyWithZone:(NSZone *)zone
//{
//  return routerManager;
//}

#pragma mark -
#pragma mark - 线程安全的单例
+ (instancetype)sharedInstance
{
  if (nil == routerManager) {
    routerManager = [[HXRouterManager alloc] init];
  }
  return routerManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
  static dispatch_once_t once;
  dispatch_once(&once , ^{
    routerManager                = [super allocWithZone:zone];
    [routerManager initData];
  });
  return routerManager;
}
- (id)copyWithZone:(NSZone *)zone
{
  return routerManager;
}


#pragma mark -
#pragma mark - Public Method
- (void)push:(NSInteger)pageId from:(UIViewController *)from params:(NSDictionary *)params delegate:(id)delegate
{
  if (self.currentPage == pageId) return;
  self.currentPage = pageId;
  if (![self pageIsRegister:pageId]) return;
  UIViewController *pageVC = [self viewControllerForPageId:pageId];
  [self setData:params toPageVC:pageVC];
  if ([pageVC respondsToSelector:@selector(setDelegate:)]) {
    [pageVC performSelector:@selector(setDelegate:) withObject:delegate];
  }
  [self pushTo:pageVC from:from];
}
- (void)popFrom:(UIViewController *)from params:(NSDictionary *)params
{
  
}
- (void)popToRootFrom:(UIViewController *)from params:(NSDictionary *)params
{
  
}


#pragma mark -
#pragma mark - Private Method
- (BOOL)pageIsRegister:(NSInteger)pageId
{
  NSArray *allKeys = [self.registerHelper.pageMap allKeys];
  BOOL hasRegister = NO;
  if ([allKeys containsObject:@(pageId)]) {
    hasRegister = YES;
  }
  else {
    NSString *showDesc   = [NSString stringWithFormat:@"请检查当前页面是否注册路由表,页面PageId == %@",@(pageId)];
    NSAssert(hasRegister == NO, showDesc);
  }
  return hasRegister;
}
- (UIViewController *)viewControllerForPageId:(NSInteger)pageId
{
  NSString *cls = self.registerHelper.pageMap[@(pageId)];
  Class class = NSClassFromString(cls);
  UIViewController *vc = [[class alloc] init];
  return vc;
}
- (void)setData:(NSDictionary *)data toPageVC:(UIViewController *)pageVC
{
  if (![data isKindOfClass:[NSDictionary class]]) return;
  [data enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
    objc_property_t property = class_getProperty([pageVC class], [key cStringUsingEncoding:NSUTF8StringEncoding]);
    if (property != nil) {
      [pageVC setValue:obj forKey:key];
    }
  }];
  
}
- (void)pushTo:(UIViewController *)pageVC from:(UIViewController *)from
{
  self.currentPage = NSNotFound;
  UIViewController *currentVC = [self getAppCurrentController];
  [currentVC.navigationController pushViewController:pageVC animated:YES];
}

- (void)initData
{
  self.registerHelper = [[HXRouterRegister alloc] init];
  self.currentPage    = NSNotFound;
}

- (UIViewController *)getAppRootController
{
  return [UIApplication sharedApplication].keyWindow.rootViewController;
}
- (UIViewController *)getAppCurrentController
{
  UIViewController *currentController = [self getAppRootController];
  BOOL runLoopFind = YES;
  while (runLoopFind) {
    if (currentController.presentedViewController) {
      currentController = currentController.presentedViewController;
    }
    else if ([currentController isKindOfClass:[UINavigationController class]]) {
      UINavigationController *navigationController = (UINavigationController *)currentController;
      currentController = [navigationController.childViewControllers lastObject];
    }
    else if ([currentController isKindOfClass:[UITabBarController class]]) {
      UITabBarController *tabBarController = (UITabBarController *)currentController;
      currentController = tabBarController.selectedViewController;
    }
    else {
      NSUInteger childViewControllerCount = currentController.childViewControllers.count;
      if (childViewControllerCount > 0) {
        currentController = currentController.childViewControllers.lastObject;
        return currentController;
      }
      else {
        return currentController;
      }
    }
  }
  return currentController;
}

#pragma mark -
#pragma mark - Getter

@end
