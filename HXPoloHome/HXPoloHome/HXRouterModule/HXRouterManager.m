//
//  HXRouterManager.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/7/30.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXRouterManager.h"

@interface HXRouterManager ()

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
    routerManager = [super allocWithZone:zone];
  });
  return routerManager;
}
- (id)copyWithZone:(NSZone *)zone
{
  return routerManager;
}


#pragma mark -
#pragma mark - Public Method
- (void)push:(NSInteger)pageId
{
  [self push:pageId params:@{}];
}
- (void)push:(NSInteger)pageId params:(NSDictionary *)params
{
  [self push:pageId params:params delegate:nil];
}

- (void)push:(NSInteger)pageId params:(NSDictionary *)params delegate:(id)delegate
{
  
}

#pragma mark -
#pragma mark - Private Method
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

@end
