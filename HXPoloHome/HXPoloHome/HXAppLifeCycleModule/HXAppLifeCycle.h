//
//  HXAppLifeCycle.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/4/28.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HXAppLifeCycle : NSObject

+ (instancetype)sharedInstance;

- (void)configAppModule;


@end

