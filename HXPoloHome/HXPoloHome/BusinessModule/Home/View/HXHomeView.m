//
//  HXHomeView.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/5/22.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXHomeView.h"

@interface HXHomeView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

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
#pragma mark - Life Cycle
- (void)layoutSubviews
{
  [super layoutSubviews];
  CGFloat w = CGRectGetWidth(self.frame);
  CGFloat h = CGRectGetHeight(self.frame);
//  if (h > w) {
//    self.titleLabel.frame = CGRectMake(0, 0, HXLen(100), HXLen(200));
//  }
//  else {
//    self.titleLabel.frame = CGRectMake(0, 0, HXLen(200), HXLen(100));
//  }
  NSLog(@"tableViewFrame -- %@",NSStringFromCGRect(self.tableView.frame));
  self.tableView.frame   = self.bounds;
  
}
- (void)drawRect:(CGRect)rect
{
  NSLog(@"rect  ----- %@",NSStringFromCGRect(rect));
}
#pragma mark -
#pragma mark - Private Method

#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"第%ld组 == %ld行",indexPath.section,indexPath.row];
  return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *name = [NSString stringWithFormat:@"我是%ld组的头部",section];
  return name;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
  NSString *name = [NSString stringWithFormat:@"我是%ld组的尾部",section];
  return name;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}
//- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//  NSArray *titleArray = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T"];
//  return titleArray;
//}
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//  return 0;
//}


#pragma mark -
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *text = [NSString stringWithFormat:@"第%ld组 == %ld行",indexPath.section,indexPath.row];
  NSLog(@"didSelectRowAtIndexPath -- %@",text);
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *text = [NSString stringWithFormat:@"第%ld组 == %ld行",indexPath.section,indexPath.row];
  NSLog(@"didDeselectRowAtIndexPath -- %@",text);
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"willDisplayCell -- ");
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
  NSLog(@"willDisplayHeaderView -- ");
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
  NSLog(@"willDisplayFooterView -- ");
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
  NSLog(@"didEndDisplayingCell -- ");
}
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
  NSLog(@"didEndDisplayingHeaderView -- ");
}
- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section
{
  NSLog(@"didEndDisplayingFooterView -- ");
}





#pragma mark -
#pragma mark - UI Method
- (void)addChildView
{
//  [self addSubview:self.titleLabel];
//  [self addSubview:self.tableView];
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
- (UITableView *)tableView
{
  if (!_tableView) {
    _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    _tableView.delegate   = self;
    _tableView.dataSource = self;
  }
  return _tableView;
}
- (UIScrollView *)scrollView
{
  if (!_scrollView) {
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor clearColor];
  }
  return _scrollView;
}

- (UIPageControl *)pageControl
{
  if (!_pageControl) {
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.pageIndicatorTintColor        = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
  }
  return _pageControl;
}

@end
