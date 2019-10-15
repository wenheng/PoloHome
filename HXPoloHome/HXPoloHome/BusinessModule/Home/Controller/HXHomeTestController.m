//
//  HXHomeTestController.m
//  HXPoloHome
//
//  Created by huangwenheng on 2019/9/16.
//  Copyright © 2019 huangwenheng. All rights reserved.
//

#import "HXHomeTestController.h"

#import "HXFlowLayout.h"
#import "HXWaterFlowLayout.h"

@interface HXHomeTestController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionLayout;
@property (nonatomic, strong) HXFlowLayout *myLayout;
@property (nonatomic, strong) HXWaterFlowLayout *waterLayout;

@end

@implementation HXHomeTestController

// 注意const的位置
static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";
static NSString *const footerId = @"footerId";

#pragma mark -
#pragma mark - Life Cycle
- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor yellowColor];
  self.navigationItem.title = @"我是标题";
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  [self.view addSubview:self.collectionView];
}
- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];
  CGRect rect = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.width * 0.6);
  self.collectionView.frame = rect;
}

- (BOOL)shouldAutorotate
{
  return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskAll;
}
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//  return UIInterfaceOrientationPortrait | UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight;
//}

#pragma mark -
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
  return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
  if([kind isEqualToString:UICollectionElementKindSectionHeader])
  {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
    if(headerView == nil)
    {
      headerView = [[UICollectionReusableView alloc] init];
    }
    headerView.backgroundColor = [UIColor grayColor];
    
    return headerView;
  }
  else if([kind isEqualToString:UICollectionElementKindSectionFooter])
  {
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:footerId forIndexPath:indexPath];
    if(footerView == nil)
    {
      footerView = [[UICollectionReusableView alloc] init];
    }
    footerView.backgroundColor = [UIColor greenColor];
    
    return footerView;
  }
  
  return nil;

}

#pragma mark -
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return CGSizeMake(50, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout*)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
  return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return 10;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//referenceSizeForHeaderInSection:(NSInteger)section
//{
//  return CGSizeMake(self.view.frame.size.width, 50);
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView
//                  layout:(UICollectionViewLayout*)collectionViewLayout
//referenceSizeForFooterInSection:(NSInteger)section
//{
//  return CGSizeMake(self.view.frame.size.width, 30);
//}

#pragma mark -
#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}
//点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
  UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
  cell.backgroundColor = [UIColor greenColor];
}
//选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSLog(@"当前选中的是 -- %ld行",indexPath.row);
}
//长按某item，弹出copy和paste的菜单
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}
//使copy和paste有效
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
  if ([NSStringFromSelector(action) isEqualToString:@"copy:"] || [NSStringFromSelector(action) isEqualToString:@"paste:"])
  {
    return YES;
  }
  
  return NO;
}
//执行操作
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender
{
  if([NSStringFromSelector(action) isEqualToString:@"copy:"])
  {
    NSLog(@"-------------执行拷贝-------------");
  }
  else if([NSStringFromSelector(action) isEqualToString:@"paste:"])
  {
    NSLog(@"-------------执行粘贴-------------");
  }
}

#pragma mark -
#pragma mark - Getter
- (UICollectionView *)collectionView
{
  if (!_collectionView) {
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.waterLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource      = self;
//    _collectionView.delegate        = self;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
    [_collectionLayout registerClass:[UIView class] forDecorationViewOfKind:@"DecorationViewOfKind"];
  }
  return _collectionView;
}
- (UICollectionViewFlowLayout *)collectionLayout
{
  if (!_collectionLayout) {
    _collectionLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
  }
  return _collectionLayout;
}

- (HXFlowLayout *)myLayout
{
  if (!_myLayout) {
    _myLayout = [[HXFlowLayout alloc] init];
  }
  return _myLayout;
}
- (HXWaterFlowLayout *)waterLayout
{
  if (!_waterLayout) {
    _waterLayout = [[HXWaterFlowLayout alloc] init];
  }
  return _waterLayout;
}



@end
