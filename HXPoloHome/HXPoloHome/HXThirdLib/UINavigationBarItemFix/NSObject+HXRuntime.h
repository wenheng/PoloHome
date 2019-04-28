//
//  NSObject+HXRuntime.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (HXRuntime)


/**
 swizzle 类方法

 @param oriSel 原有的方法
 @param swiSel 交换的方法
 */
+ (void)swizzleClassMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;


/**
 swizzle 实例方法

 @param oriSel 原有的方法
 @param swiSel 交换的方法
 */
+ (void)swizzleInstanceMethodWithOriginSel:(SEL)oriSel swizzledSel:(SEL)swiSel;


/**
 判断方法是否在子类里 override了

 @param cls 传入要判断的Class
 @param sel 传入要判断的Selector
 @return 返回判断是否被重载的结果
 */
- (BOOL)isMethodOverride:(Class)cls selector:(SEL)sel;


/**
 判断当前类是否在主bundle里

 @param cls 传入的类
 @return 返回判断结果
 */
+ (BOOL)isMainBundleClass:(Class)cls;


/**
 动态创建绑定Selector的类
 tip: 每当无法找到Selector转发过来的所有Selector都会追加到当前Class上

 @param aSelector 传入的Selector
 @return 返回创建的类
 */
+ (Class)addMethodToSubClass:(SEL)aSelector;


@end

