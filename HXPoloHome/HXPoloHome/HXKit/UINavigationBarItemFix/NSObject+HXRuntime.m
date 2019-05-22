//
//  NSObject+HXRuntime.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "NSObject+HXRuntime.h"
#import <objc/runtime.h>

char * const kProtectCrashProtectorName = "kProtectCrashProtectorName";

void ProtectCrashProtectd(id self, SEL sel)
{
  
}

@implementation NSObject (HXRuntime)

+ (void)swizzleClassMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel
{
  Class cls                        = object_getClass(self);
  Method originAddObserverMethod   = class_getClassMethod(cls, oriSel);
  Method swizzledAddObserverMethod = class_getClassMethod(cls, swiSel);
  [self swizzleMethodWithOriginSel:oriSel oriMethod:originAddObserverMethod swizzleSel:swiSel swizzledMethod:swizzledAddObserverMethod class:cls];
}

+ (void)swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel
{
  Method originAddObserverMethod   = class_getInstanceMethod(self, oriSel);
  Method swizzledAddObserverMethod = class_getInstanceMethod(self, swiSel);
  
  [self swizzleMethodWithOriginSel:oriSel oriMethod:originAddObserverMethod swizzleSel:swiSel swizzledMethod:swizzledAddObserverMethod class:self];
}

+ (void)swizzleMethodWithOriginSel:(SEL)oriSel
                         oriMethod:(Method)oriMethod
                        swizzleSel:(SEL)swizzledSel
                    swizzledMethod:(Method)swizzledMethod
                             class:(Class)cls
{
  BOOL didAddMethod = class_addMethod(cls, oriSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
  if (didAddMethod) {
    class_replaceMethod(cls, swizzledSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
  }
  else {
    method_exchangeImplementations(oriMethod, swizzledMethod);
  }
}

+ (Class)addMethodToSubClass:(SEL)aSelector
{
  Class ProtectCrashProtector = objc_getClass(kProtectCrashProtectorName);
  if (!ProtectCrashProtector) {
    ProtectCrashProtector = objc_allocateClassPair([NSObject class], kProtectCrashProtectorName, sizeof([NSObject class]));
    objc_registerClassPair(ProtectCrashProtector);
  }
  class_addMethod(ProtectCrashProtector, aSelector, (IMP)ProtectCrashProtectd, "v@:");
  return ProtectCrashProtector;
}

- (BOOL)isMethodOverride:(Class)cls selector:(SEL)sel
{
  IMP clsIMP      = class_getMethodImplementation(cls, sel);
  IMP superClsIMP = class_getMethodImplementation([cls superclass], sel);
  return clsIMP != superClsIMP;
  
}
+ (BOOL)isMainBundleClass:(Class)cls
{
  return cls && [[NSBundle bundleForClass:cls] isEqual:[NSBundle mainBundle]];
}


@end
