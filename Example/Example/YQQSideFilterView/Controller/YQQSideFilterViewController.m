//
//  YQQSideFilterViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/17.
//

#import "YQQSideFilterViewController.h"
#import "YQQCollectionPushReusableHeaderView.h"
#import "YQQCollectionSwitchReusableHeaderView.h"
#import "YQQCollectionReusableFooterView.h"
#import "YQQCollectionViewNormalCell.h"
#import "YQQSideFilterCategoryModel.h"
#import "YQQSideFilterItem.h"
#import "YQQCollectionBaseReusableView.h"
#import "YQQCompanyViewController.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define Filter_ORIGIN_FRAME CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH - self.sideSlipLeading, SCREEN_HEIGHT)
#define Filter_DISTINATION_FRAME CGRectMake(self.sideSlipLeading, 0, SCREEN_WIDTH - self.sideSlipLeading, SCREEN_HEIGHT)
#define Filter_Bottom_Height 62

@interface YQQSideFilterViewController () <UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource, YQQCollectionBaseReusableViewDelegate>

@property (nonatomic, strong) UIView *dimView;

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YQQSideFilterViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self];
        _sideSlipLeading = 100;
        _navigationController.view.frame = Filter_ORIGIN_FRAME;
        _navigationController.navigationBarHidden = YES;
        _navigationController.navigationBar.translucent = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:[UIScreen mainScreen].bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *shapLayer = [CAShapeLayer layer];
    shapLayer.path = bezierPath.CGPath;
    self.view.layer.mask = shapLayer;
    
    [self UIConfiguration];
}

- (void)UIConfiguration {
    UIView *bottomBar = [self createBottomBar];
    [self.view addSubview:bottomBar];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[bottomBar]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomBar)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[bottomBar]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(bottomBar)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bottomBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:62]];
    
    [self.view addSubview:self.collectionView];
    UICollectionView *collectionView = self.collectionView;
    NSDictionary *tableViewMetrics = @{@"top": @(0), @"leading":@(0), @"bottom": @(62), @"trailing":@(0)};
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(leading)-[collectionView]-(trailing)-|" options:0 metrics:tableViewMetrics views:NSDictionaryOfVariableBindings(collectionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[collectionView]-(bottom)-|" options:0 metrics:tableViewMetrics views:NSDictionaryOfVariableBindings(collectionView)]];
}

#pragma mark - YQQCollectionBaseReusableViewDelegate

- (void)reusableView:(YQQCollectionBaseReusableView *)reusableView didSelectModel:(YQQSideFilterCategoryModel *)categoryModel {
    if (categoryModel.type == YQQSideFilterCategoryModelTypePush) {
        [self.navigationController pushViewController:[YQQCompanyViewController new] animated:YES];
    } else if (categoryModel.type == YQQSideFilterCategoryModelTypeSwitch) {
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:reusableView.indexPath.section]];
        if (categoryModel.isOpen) {
            [self.collectionView selectItemAtIndexPath:reusableView.indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredVertically];
        }
    }
}

#pragma mark - UICollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    YQQSideFilterCategoryModel *categoryModel = [self.dataArray objectAtIndex:section];
    return CGSizeMake(self.view.frame.size.width, categoryModel.headerHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    YQQSideFilterCategoryModel *categoryModel = [self.dataArray objectAtIndex:section];
    return CGSizeMake(self.view.frame.size.width, categoryModel.footerHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YQQSideFilterCategoryModel *categoryModel = [self.dataArray objectAtIndex:indexPath.section];
    YQQSideFilterItem *item = [categoryModel.items objectAtIndex:indexPath.item];
    item.selected = !item.selected;
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(75, 28);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 16, 8, 16);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    YQQSideFilterCategoryModel *categoryModel = [self.dataArray objectAtIndex:section];
    if (categoryModel.type == YQQSideFilterCategoryModelTypeSwitch) {
        if (categoryModel.isOpen) {
            return categoryModel.items.count;
        } else {
            return 0;
        }
    } else {
        return categoryModel.items.count;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    YQQSideFilterCategoryModel *categoryModel = [self.dataArray objectAtIndex:indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YQQCollectionBaseReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:categoryModel.headerReuseIdentifier forIndexPath:indexPath];
        reusableView.categoryModel = categoryModel;
        reusableView.delegate = self;
        reusableView.indexPath = indexPath;
        return reusableView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        YQQCollectionBaseReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:categoryModel.footerReuseIdentifier forIndexPath:indexPath];
        reusableView.categoryModel = categoryModel;
        reusableView.delegate = self;
        reusableView.indexPath = indexPath;
        return reusableView;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YQQSideFilterCategoryModel *categoryModel = [self.dataArray objectAtIndex:indexPath.section];
    YQQSideFilterItem *item = [categoryModel.items objectAtIndex:indexPath.item];
    YQQCollectionViewNormalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.reuseIdentifier forIndexPath:indexPath];
    cell.item = [categoryModel.items objectAtIndex:indexPath.item];
    return cell;
}

#pragma mark - Public

- (void)show {
    [self.dimView addSubview:_navigationController.view];
    [[UIApplication sharedApplication].delegate.window addSubview:self.dimView];
    [UIView animateWithDuration:0.3 animations:^{
        self.dimView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.navigationController.view.frame = Filter_DISTINATION_FRAME;
    }];
}

- (void)close {
    [UIView animateWithDuration:0.3 animations:^{
        self.dimView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.navigationController.view.frame = Filter_ORIGIN_FRAME;
    } completion:^(BOOL finished) {
        [self.navigationController.view removeFromSuperview];
        [self.dimView removeFromSuperview];
    }];
}

#pragma mark - Action

- (void)clickDimView:(UITapGestureRecognizer *)tap {
    [self close];
}

- (void)commitButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sideFilterViewController:didSelectActionType:)]) {
        [self.delegate sideFilterViewController:self didSelectActionType:YQQSideFilterViewControllerActionTypeConfirm];
    }
    [self close];
}

- (void)resetButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(sideFilterViewController:didSelectActionType:)]) {
        [self.delegate sideFilterViewController:self didSelectActionType:YQQSideFilterViewControllerActionTypeReset];
    }
}

- (UIView *)createBottomBar {
    UIView *view = [[UIView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:topLine];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(0)-[topLine]-(0)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLine)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[topLine]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(topLine)]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:topLine attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:1]];

    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:resetButton];
    [resetButton setTitle:@"重置" forState:UIControlStateNormal];
    resetButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [resetButton setTitleColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0] forState:UIControlStateNormal];
    [resetButton setBackgroundColor:[UIColor whiteColor]];
    resetButton.layer.cornerRadius = 15;
    resetButton.layer.borderColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0].CGColor;
    resetButton.layer.borderWidth = 1;
    [resetButton addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:commitButton];
    [commitButton setTitle:@"确定" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton setBackgroundColor:[UIColor colorWithRed:26/255.0 green:203/255.0 blue:151/255.0 alpha:1.0]];
    commitButton.layer.cornerRadius = 15;
    commitButton.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
    commitButton.layer.borderWidth = 1;
    [commitButton addTarget:self action:@selector(commitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[resetButton]-(16)-[commitButton]-(16)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(resetButton, commitButton)]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:resetButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:30]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:commitButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:30]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:resetButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:commitButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:resetButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:commitButton attribute:NSLayoutAttributeWidth multiplier:1.f constant:0]];
    return view;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(touch.view == self.dimView) {
        return YES;
    }
    return NO;
}

#pragma mark - Associated

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.bounces = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionViewNormalCell" bundle:nil] forCellWithReuseIdentifier:@"YQQCollectionViewNormalCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionPushReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YQQCollectionPushReusableHeaderView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionSwitchReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YQQCollectionSwitchReusableHeaderView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionReusableFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YQQCollectionReusableFooterView"];
    }
    return _collectionView;
}

- (UIView *)dimView {
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _dimView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDimView:)];
        tap.delegate = self;
        [_dimView addGestureRecognizer:tap];
    }
    return _dimView;
}

@end
