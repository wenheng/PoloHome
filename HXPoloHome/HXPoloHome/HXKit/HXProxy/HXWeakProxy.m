//
//  HXWeakProxy.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/27.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXWeakProxy.h"

@interface HXWeakProxy ()

@property (nonatomic, strong) id target;

@end

@implementation HXWeakProxy

#pragma mark -
#pragma mark - Init Method
+ (instancetype)proxyWithTarget:(id)target
{
  return [[self alloc] initWithTarget:target];
}
- (instancetype)initWithTarget:(id)target
{
  _target = target;
  return self;
}

#pragma mark -
#pragma mark - Override Method
//获得方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
  return [self.target methodSignatureForSelector:sel];
}
//改变方法调用对象，让消息实际上发给真正的实现这方法的类
- (void)forwardInvocation:(NSInvocation *)invocation
{
  SEL sel = [invocation selector];
  if ([self.target respondsToSelector:sel]) {
    [invocation invokeWithTarget:self.target];
  }
}
- (BOOL)respondsToSelector:(SEL)aSelector
{
  return [self.target respondsToSelector:aSelector];
}
@end
