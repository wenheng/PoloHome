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
#pragma mark - Private Method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  NSLog(@"%s",__FUNCTION__);
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  NSLog(@"%s",__FUNCTION__);
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  NSLog(@"%s",__FUNCTION__);
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
  NSLog(@"%s",__FUNCTION__);
}
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
  NSLog(@"%s",__FUNCTION__);
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
  NSLog(@"%s",__FUNCTION__);
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
  NSLog(@"%s",__FUNCTION__);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  if ([self pointInside:CGPointMake(10, 10) withEvent:event]) {
    NSLog(@"我的点在里面哈哈哈哈哈");
  }
  return self;
}

#pragma mark -
#pragma mark - UI Method
- (void)addChildView
{
  self.backgroundColor = [UIColor purpleColor];
  [self addSubview:self.titleLabel];
  self.titleLabel.frame = CGRectMake(0, 0, HXLen(100), HXLen(200));
}

#pragma mark -
#pragma mark - Getter
- (UILabel *)titleLabel
{
  if(!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor yellowColor];
  }
  return _titleLabel;
}


@end
