//
//  YQQSideFilterViewController.m
//  Example
//
//  Created by 朱逸 on 2021/3/19.
//

#import "YQQSideFilterViewController.h"

@interface YQQSideFilterViewController () <UIGestureRecognizerDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *dimView;

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *bottomButtonContainer;

@property (nonatomic, strong) UIView *bottomButtonContainerSeparator;

@property (nonatomic, strong) UIButton *resetButton;

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, assign) CGRect contentFrame;

@end

@implementation YQQSideFilterViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self];
        _sideSlipLeading = 100;
        _bottomButtonContainerHeight = 62;
        _navigationController.navigationBar.translucent = NO;
        
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:[UIScreen mainScreen].bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *shapLayer = [CAShapeLayer layer];
        shapLayer.path = bezierPath.CGPath;
        self.view.layer.mask = shapLayer;
        
        [self.view addSubview:self.bottomButtonContainer];
        [self.bottomButtonContainer addSubview:self.bottomButtonContainerSeparator];
        [self.bottomButtonContainer addSubview:self.resetButton];
        [self.bottomButtonContainer addSubview:self.confirmButton];
        [self.view addSubview:self.collectionView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _navigationController.navigationBarHidden = YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.bottomButtonContainer.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - _bottomButtonContainerHeight, CGRectGetWidth(self.view.frame), _bottomButtonContainerHeight);
    self.bottomButtonContainerSeparator.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 1);
    self.resetButton.frame = CGRectMake(16, 16, (CGRectGetWidth(self.view.frame) - 48) / 2.0, 30);
    self.confirmButton.frame = CGRectMake(32 + (CGRectGetWidth(self.view.frame) - 48) / 2.0, 16, (CGRectGetWidth(self.view.frame) - 48) / 2.0, 30);
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - _bottomButtonContainerHeight);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _navigationController.navigationBarHidden = NO;
}

- (void)dealloc {
    NSLog(@"%@♻️", NSStringFromClass([self class]));
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if(touch.view == self.dimView) {
        return YES;
    }
    return NO;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sideFilterViewController:referenceSizeForHeaderInSection:)]) {
        return [self.dataSource sideFilterViewController:self referenceSizeForHeaderInSection:section];
    } else {
        return CGSizeMake(self.view.frame.size.width, 60);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sideFilterViewController:referenceSizeForFooterInSection:)]) {
        return [self.dataSource sideFilterViewController:self referenceSizeForFooterInSection:section];
    } else {
        return CGSizeMake(self.view.frame.size.width, 60);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(sideFilterViewController:sizeForItemAtIndexPath:)]) {
        return [self.dataSource sideFilterViewController:self sizeForItemAtIndexPath:indexPath];
    } else {
        return CGSizeMake(floorf(self.view.frame.size.width / 3.0), 30);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sideFilterViewController:insetForSectionAtIndex:)]) {
        return [self.dataSource sideFilterViewController:self insetForSectionAtIndex:section];
    } else {
        return UIEdgeInsetsMake(8, 16, 8, 16);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sideFilterViewController:minimumLineSpacingForSectionAtIndex:)]) {
        return [self.dataSource sideFilterViewController:self minimumLineSpacingForSectionAtIndex:section];
    } else {
        return 16;
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sideFilterViewController:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [self.dataSource sideFilterViewController:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return 16;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(sideFilterViewController:didSelectItemAtIndexPath:)]) {
        [self.delegate sideFilterViewController:self didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(sideFilterViewController:numberOfItemsInSection:)]) {
        return [self.dataSource sideFilterViewController:self numberOfItemsInSection:section];
    }
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInsideFilterViewController:)]) {
        return [self.dataSource numberOfSectionsInsideFilterViewController:self];
    } else {
        return 1;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView;
    if ([self.delegate respondsToSelector:@selector(sideFilterViewController:viewForSupplementaryElementOfKind:atIndexPath:)]) {
        reusableView = [self.dataSource sideFilterViewController:self viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.dataSource sideFilterViewController:self cellForItemAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Public

- (void)show {
    [self showInView:[UIApplication sharedApplication].delegate.window];
}

- (void)showInView:(UIView *)view {
    self.dimView.frame = view.bounds;
    _navigationController.view.frame = CGRectMake(self.dimView.frame.size.width, 0, self.dimView.frame.size.width - self.sideSlipLeading, self.dimView.frame.size.height);
    [view addSubview:self.dimView];
    [self.dimView addSubview:self.navigationController.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.dimView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        self.navigationController.view.frame = CGRectMake(self.sideSlipLeading, 0, self.dimView.frame.size.width - self.sideSlipLeading, self.dimView.frame.size.height);
    }];
}

- (void)close {
    [UIView animateWithDuration:0.3 animations:^{
        self.dimView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.navigationController.view.frame =  CGRectMake(self.dimView.frame.size.width, 0, self.dimView.frame.size.width - self.sideSlipLeading, self.dimView.frame.size.height);
    } completion:^(BOOL finished) {
        [self.dimView removeFromSuperview];
    }];
}

- (void)reloadData {
    [self.collectionView reloadData];
}

- (void)pushViewController:(UIViewController *)controller {
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)registerClass:(Class)Class forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:Class forCellWithReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
}

- (void)registerClass:(nullable Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier];
}
- (void)registerNib:(nullable UINib *)nib forSupplementaryViewOfKind:(NSString *)kind withReuseIdentifier:(NSString *)identifier {
    [self.collectionView registerNib:nib forSupplementaryViewOfKind:kind withReuseIdentifier:identifier];
}

- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *reusableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier forIndexPath:indexPath];
        return reusableView;
    } else if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        UICollectionReusableView *reusableView = [self.collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:identifier forIndexPath:indexPath];
        return reusableView;
    } else {
        return nil;
    }
}

#pragma mark - Action

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
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionViewNormalCell" bundle:nil] forCellWithReuseIdentifier:@"YQQCollectionViewNormalCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionPushReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YQQCollectionPushReusableHeaderView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionSwitchReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YQQCollectionSwitchReusableHeaderView"];
        [_collectionView registerNib:[UINib nibWithNibName:@"YQQCollectionReusableFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YQQCollectionReusableFooterView"];
    }
    return _collectionView;
}

- (UIButton *)resetButton {
    if (!_resetButton) {
        if ([self.dataSource respondsToSelector:@selector(resetButtonForSideFilterViewController:)]) {
            _resetButton = [self.dataSource resetButtonForSideFilterViewController:self];
        } else {
            _resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _resetButton.translatesAutoresizingMaskIntoConstraints = NO;
            [_resetButton setTitle:@"重置" forState:UIControlStateNormal];
            _resetButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
            [_resetButton setTitleColor:[UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0] forState:UIControlStateNormal];
            [_resetButton setBackgroundColor:[UIColor whiteColor]];
            _resetButton.layer.cornerRadius = 15;
            _resetButton.layer.borderColor = [UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1.0].CGColor;
            _resetButton.layer.borderWidth = 1;
            [_resetButton addTarget:self action:@selector(resetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _resetButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        if ([self.dataSource respondsToSelector:@selector(confirmButtonForSideFilterViewController:)]) {
            _confirmButton = [self.dataSource confirmButtonForSideFilterViewController:self];
        } else {
            _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
            [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
            _confirmButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
            [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_confirmButton setBackgroundColor:[UIColor colorWithRed:26/255.0 green:203/255.0 blue:151/255.0 alpha:1.0]];
            _confirmButton.layer.cornerRadius = 15;
            _confirmButton.layer.borderColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0].CGColor;
            _confirmButton.layer.borderWidth = 1;
            [_confirmButton addTarget:self action:@selector(commitButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return _confirmButton;
}

- (UIView *)bottomButtonContainer {
    if (!_bottomButtonContainer) {
        _bottomButtonContainer = UIView.new;
        _bottomButtonContainer.backgroundColor = UIColor.whiteColor;
        _bottomButtonContainer.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomButtonContainer;
}

- (UIView *)bottomButtonContainerSeparator {
    if (!_bottomButtonContainerSeparator) {
        _bottomButtonContainerSeparator = [[UIView alloc] init];
        _bottomButtonContainerSeparator.backgroundColor = [UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:1];
        _bottomButtonContainerSeparator.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _bottomButtonContainerSeparator;
}

- (UIView *)dimView {
    if (!_dimView) {
        _dimView = [[UIView alloc] init];
        _dimView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        tap.delegate = self;
        [_dimView addGestureRecognizer:tap];
    }
    return _dimView;
}

@end
