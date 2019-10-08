//
//  HXInheritProxy.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/27.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXInheritProxy.h"

@interface HXInheritProxy ()

@property (nonatomic, strong) NSObject *object;
@end

@implementation HXInheritProxy

- (id)transformToObject:(NSObject *)object
{
  self.object = object;
  return self.object;
}

#pragma mark -
#pragma mark - Override Method
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
  NSMethodSignature *methodSignature;
  if (self.object) {
    methodSignature = [self.object methodSignatureForSelector:sel];
  }
  else {
    methodSignature = [super methodSignatureForSelector:sel];
  }
  return methodSignature;
}
- (void)forwardInvocation:(NSInvocation *)invocation
{
  if (self.object) {
    [invocation setTarget:self.object];
    [invocation invoke];
  }
}
@end
