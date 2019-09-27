//
//  HXWeakProxy.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/27.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;
- (instancetype)initWithTarget:(id)target;


@end

NS_ASSUME_NONNULL_END
