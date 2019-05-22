//
//  NSArray+HX.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/2/13.
//  Copyright © 2019年 huangwenheng. All rights reserved.
//

#import "NSArray+HX.h"

@implementation NSArray (HX)

- (NSArray *)hx_removeSameElement
{
  NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithArray:self];
  return [set array];
}

- (NSArray *)hx_reversedArray
{
  NSArray *reversedArray = [[self reverseObjectEnumerator] allObjects];
  return reversedArray;
}

@end
