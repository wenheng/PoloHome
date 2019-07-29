//
//  HXHomeView.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXHomeView.h"

@interface HXHomeView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HXHomeView

#pragma mark -
#pragma mark - Init Method
- (instancetype)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    [self addChildView];
  }
  return self;
}

#pragma mark -
#pragma mark - UI Method
- (void)addChildView
{
  self.backgroundColor = [UIColor orangeColor];
  [self addSubview:self.titleLabel];
  self.titleLabel.frame = CGRectMake(0, 0, 100, 200);
}

#pragma mark -
#pragma mark - Getter
- (UILabel *)titleLabel
{
  if(!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor redColor];
  }
  return _titleLabel;
}


@end
