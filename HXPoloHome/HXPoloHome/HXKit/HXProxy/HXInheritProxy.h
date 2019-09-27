//
//  HXInheritProxy.h
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/27.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HXInheritProxy : NSProxy

- (id)transformToObject:(NSObject *)object;

@end

NS_ASSUME_NONNULL_END
