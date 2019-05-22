//
//  HXNavigationBar.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXNavigationBar.h"

@interface HXNavigationBar ()

@property (nonatomic, strong) UIImageView *shadowImageView;
@property (nonatomic, strong) UIVisualEffectView *fakeView;
@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation HXNavigationBar

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
  if (!self.isUserInteractionEnabled || self.isHidden || self.alpha <= 0.01) return nil;
  
  UIView *view = [super hitTest:point withEvent:event];
  NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
  
  if (view && [viewName isEqualToString:@"HXNavigationBar"]) {
    
    for (UIView *subView in self.subviews) {
      NSString *viewName = [[[view classForCoder] description] stringByReplacingOccurrencesOfString:@"_" withString:@""];
      NSArray *array = @[@"UINavigationItemButtonView"];
      if ([array containsObject:viewName]) {
        CGPoint convertedPoint = [self convertPoint:point toView:subView];
        CGRect bounds = subView.bounds;
        if (bounds.size.width < 80) {
          bounds = CGRectInset(bounds, bounds.size.width - 80, 0);
        }
        if (CGRectContainsPoint(bounds, convertedPoint)) {
          return view;
        }
      }
    }
  }
  
  NSArray *array = @[@"UINavigationBarContentView",@"HXNavigationBar"];
  if ([array containsObject:viewName]) {
    if (self.backgroundImageView.image) {
      if (self.backgroundImageView.alpha < 0.01) {
        return nil;
      }
    }
    else if (self.fakeView.alpha < 0.01) {
      return nil;
    }
  }
  
  if (CGRectEqualToRect(view.bounds, CGRectZero)) {
    return nil;
  }
  return view;
}

#pragma mark -
#pragma mark - Life Cycle
- (void)layoutSubviews
{
  [super layoutSubviews];
  
  self.fakeView.frame            = self.fakeView.superview.bounds;
  self.backgroundImageView.frame = self.backgroundImageView.superview.bounds;
  self.shadowImageView.frame     = CGRectMake(0, CGRectGetHeight(self.shadowImageView.superview.bounds)-0.5, CGRectGetWidth(self.shadowImageView.superview.bounds), 0.5);
}

#pragma mark -
#pragma mark - UI Method
- (void)makeSureFakeView
{
  [UIView setAnimationsEnabled:NO];
  
  if (!self.fakeView.superview) {
    [[self.subviews firstObject] insertSubview:_fakeView atIndex:0];
    self.fakeView.frame = self.fakeView.superview.bounds;
  }
  
  if (!self.shadowImageView.superview) {
    [[self.subviews firstObject] insertSubview:_shadowImageView aboveSubview:self.backgroundImageView];
    self.shadowImageView.frame = CGRectMake(0, CGRectGetHeight(self.shadowImageView.superview.bounds) - 0.5, CGRectGetWidth(self.shadowImageView.superview.bounds), 0.5);
  }
  
  if (!self.backgroundImageView.superview) {
    [[self.subviews firstObject] insertSubview:_backgroundImageView aboveSubview:self.fakeView];
    self.backgroundImageView.frame = self.backgroundImageView.superview.bounds;
  }
  
  [UIView setAnimationsEnabled:YES];
}

#pragma mark -
#pragma mark - Setter
- (void)setBarTintColor:(UIColor *)barTintColor
{
  self.fakeView.subviews.lastObject.backgroundColor = barTintColor;
  [self makeSureFakeView];
}
- (void)setBackgroundImage:(UIImage *)backgroundImage forBarMetrics:(UIBarMetrics)barMetrics
{
  self.backgroundImageView.image = backgroundImage;
  [self makeSureFakeView];
}
- (void)setTranslucent:(BOOL)translucent
{
  [super setTranslucent:YES];
}
- (void)setShadowImage:(UIImage *)shadowImage
{
  self.shadowImageView.image = shadowImage;
  if (shadowImage) {
    self.shadowImageView.backgroundColor = nil;
  }
  else {
    self.shadowImageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:77.0/255];
  }
}

#pragma mark -
#pragma mark - Getter
- (UIVisualEffectView *)fakeView
{
  if (!_fakeView) {
    [super setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    _fakeView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    _fakeView.userInteractionEnabled = NO;
    _fakeView.autoresizingMask       = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [[self.subviews firstObject] insertSubview:_fakeView atIndex:0];
  }
  return _fakeView;
}

- (UIImageView *)backgroundImageView
{
  if (!_backgroundImageView) {
    _backgroundImageView = [[UIImageView alloc] init];
    _backgroundImageView.userInteractionEnabled = NO;
    _backgroundImageView.contentScaleFactor     = 1;
    _backgroundImageView.contentMode            = UIViewContentModeScaleToFill;
    _backgroundImageView.autoresizingMask       = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [[self.subviews firstObject] insertSubview:_backgroundImageView aboveSubview:self.fakeView];
  }
  return _backgroundImageView;
}

- (UIImageView *)shadowImageView
{
  if (!_shadowImageView) {
    _shadowImageView = [[UIImageView alloc] init];
    [super setShadowImage:[UIImage new]];
    
    _shadowImageView = [[UIImageView alloc] init];
    _shadowImageView.userInteractionEnabled = YES;
    _shadowImageView.contentScaleFactor     = 1;
    [[self.subviews firstObject] insertSubview:_shadowImageView aboveSubview:self.backgroundImageView];
  }
  return _shadowImageView;
}


@end
