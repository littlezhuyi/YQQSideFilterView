//
//  ViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/17.
//

#import "ViewController.h"
#import "YQQSideFilterViewController.h"
#import "YQQCollectionPushReusableHeaderView.h"
#import "YQQCollectionSwitchReusableHeaderView.h"
#import "YQQCollectionReusableFooterView.h"
#import "YQQCollectionViewNormalCell.h"
#import "YQQSideFilterCategoryModel.h"
#import "YQQSideFilterItem.h"
#import "YQQCollectionBaseReusableView.h"
#import "YQQCompanyViewController.h"
#import "YQQCompanyViewController.h"

@interface ViewController () <YQQSideFilterViewControllerDelegate, YQQSideFilterViewControllerDataSource, YQQCollectionBaseReusableViewDelegate>

@property (nonatomic, strong) YQQSideFilterViewController *sideFillterViewController;

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [self createGroupModel];
    [self.sideFillterViewController reloadData];
}

- (IBAction)show:(UIButton *)sender {
    [self.sideFillterViewController show];
}

- (YQQSideFilterViewController *)sideFillterViewController {
    if (!_sideFillterViewController) {
        _sideFillterViewController = [[YQQSideFilterViewController alloc] init];
        _sideFillterViewController.delegate = self;
        _sideFillterViewController.dataSource = self;
        _sideFillterViewController.sideSlipLeading = 100;
        _sideFillterViewController.bottomButtonContainerHeight = 80;
        [_sideFillterViewController registerNib:[UINib nibWithNibName:@"YQQCollectionViewNormalCell" bundle:nil] forCellWithReuseIdentifier:@"YQQCollectionViewNormalCell"];
        [_sideFillterViewController registerNib:[UINib nibWithNibName:@"YQQCollectionPushReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YQQCollectionPushReusableHeaderView"];
        [_sideFillterViewController registerNib:[UINib nibWithNibName:@"YQQCollectionSwitchReusableHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YQQCollectionSwitchReusableHeaderView"];
        [_sideFillterViewController registerNib:[UINib nibWithNibName:@"YQQCollectionReusableFooterView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"YQQCollectionReusableFooterView"];
    }
    return _sideFillterViewController;
}

#pragma mark -YQQCollectionBaseReusableViewDelegate

- (void)reusableView:(YQQCollectionBaseReusableView *)reusableView didSelectModel:(YQQSideFilterCategoryModel *)categoryModel {
    if (categoryModel.type == YQQSideFilterCategoryModelTypePush) {
        YQQCompanyViewController *controller = [YQQCompanyViewController new];
        [self.sideFillterViewController pushViewController:controller];
    } else if (categoryModel.type == YQQSideFilterCategoryModelTypeSwitch) {
        categoryModel.isOpen = !categoryModel.isOpen;
        [self.sideFillterViewController reloadData];
    }
}

- (void)sideFilterViewController:(YQQSideFilterViewController *)sideFilterViewController didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - YQQSideFilterViewDelegate

- (void)sideFilterViewController:(YQQSideFilterViewController *)sideFilterViewController didSelectActionType:(YQQSideFilterViewControllerActionType)actionType {
    if (actionType == YQQSideFilterViewControllerActionTypeReset) {
        sideFilterViewController.dataArray = [self createGroupModel];
    }
}

#pragma mark - YQQSideFilterViewDataSource

- (UICollectionViewCell *_Nullable)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController cellForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath {
    YQQSideFilterCategoryModel *filterModel = [self.dataArray objectAtIndex:indexPath.section];
    YQQSideFilterItem *item = [filterModel.items objectAtIndex:indexPath.item];
    YQQCollectionViewNormalCell *normalCell = [sideFilterViewController dequeueReusableCellWithReuseIdentifier:item.reuseIdentifier forIndexPath:indexPath];
    normalCell.item = item;
    return normalCell;
}

- (NSInteger)sideFilterViewController:(YQQSideFilterViewController *)sideFilterViewController numberOfItemsInSection:(NSInteger)section {
    YQQSideFilterCategoryModel *filterModel = [self.dataArray objectAtIndex:section];
    return filterModel.isOpen ? filterModel.items.count : 0;
}

- (NSInteger)numberOfSectionsInsideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController {
    return self.dataArray.count;
}

- (UICollectionReusableView *_Nullable)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController viewForSupplementaryElementOfKind:(NSString *_Nullable)kind atIndexPath:(NSIndexPath *_Nullable)indexPath {
    YQQSideFilterCategoryModel *categoryModel = [self.dataArray objectAtIndex:indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        YQQCollectionBaseReusableView *reusableView = [sideFilterViewController dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:categoryModel.headerReuseIdentifier forIndexPath:indexPath];
        reusableView.categoryModel = categoryModel;
        reusableView.delegate = self;
        reusableView.indexPath = indexPath;
        return reusableView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        YQQCollectionBaseReusableView *reusableView = [sideFilterViewController dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:categoryModel.footerReuseIdentifier forIndexPath:indexPath];
        reusableView.categoryModel = categoryModel;
        reusableView.delegate = self;
        reusableView.indexPath = indexPath;
        return reusableView;
    }
    return nil;
}

- (CGSize)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController sizeForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath {
    return CGSizeMake(75, 28);
}

- (UIEdgeInsets)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 16, 8, 16);
}

- (CGFloat)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

- (CGFloat)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}

- (CGSize)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width - 100, 70);
}

- (CGSize)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(UIScreen.mainScreen.bounds.size.width - 100, 0);
}

#pragma mark -

- (NSArray *)createGroupModel {
    return @[[self createFilterModel:@"机动车所有人" subTitle:@"首汽租赁有限责任公司齐齐哈尔分公司" open:YES type:YQQSideFilterCategoryModelTypePush],
             [self createFilterModel:@"机动车使用人" subTitle:@"首汽租赁有限责任公司北京分公司" open:YES type:YQQSideFilterCategoryModelTypePush],
             [self createFilterModel:@"车态" subTitle:@"" open:YES type:YQQSideFilterCategoryModelTypeSwitch],
             [self createFilterModel:@"租赁用途" subTitle:@"" open:YES type:YQQSideFilterCategoryModelTypeNone]];
}

- (YQQSideFilterCategoryModel *)createFilterModel:(NSString *)classification subTitle:(NSString *)subTitle open:(BOOL)isOpen type:(YQQSideFilterCategoryModelType)type {
    YQQSideFilterCategoryModel *filterModel = [[YQQSideFilterCategoryModel alloc] init];
    filterModel.classification = classification;
    filterModel.subTitle = subTitle;
    filterModel.isOpen = isOpen;
    filterModel.type = type;
    filterModel.footerHeight = 0;
    filterModel.footerReuseIdentifier = @"YQQCollectionReusableFooterView";
    if ([classification isEqualToString:@"机动车所有人"]) {
        filterModel.headerReuseIdentifier = @"YQQCollectionPushReusableHeaderView";
        filterModel.headerHeight = 67;
        filterModel.items = [self createOwnerArray];
    } else if ([classification isEqualToString:@"机动车使用人"]) {
        filterModel.headerReuseIdentifier = @"YQQCollectionPushReusableHeaderView";
        filterModel.headerHeight = 67;
        filterModel.items = [self createUserArray];
    } else if ([classification isEqualToString:@"车态"]) {
        filterModel.headerReuseIdentifier = @"YQQCollectionSwitchReusableHeaderView";
        filterModel.headerHeight = 45;
        filterModel.items = [self createStateArray];
    } else if ([classification isEqualToString:@"租赁用途"]) {
        filterModel.headerReuseIdentifier = @"YQQCollectionSwitchReusableHeaderView";
        filterModel.headerHeight = 45;
        filterModel.items = [self createPurposeArray];
    }
    return filterModel;
}

- (NSArray *)createOwnerArray {
    return @[
        
    ];
}

- (NSArray *)createUserArray {
    return @[
        
    ];
}

- (NSArray *)createStateArray {
    return @[
        [self createItem:@"未上牌" code:@"1002" selected:NO],
        [self createItem:@"已上牌" code:@"1002" selected:NO],
        [self createItem:@"正常运营" code:@"1003" selected:NO],
        [self createItem:@"维修" code:@"1004" selected:NO],
        [self createItem:@"调拨" code:@"1005" selected:NO],
        [self createItem:@"失控" code:@"1006" selected:NO],
        [self createItem:@"待售" code:@"1007" selected:NO],
        [self createItem:@"已售" code:@"1008" selected:NO]
    ];
}

- (NSArray *)createPurposeArray {
    return @[
        [self createItem:@"长租" code:@"1002" selected:NO],
        [self createItem:@"短租" code:@"1002" selected:NO],
        [self createItem:@"商务车队" code:@"1003" selected:NO],
        [self createItem:@"新能源" code:@"1004" selected:NO],
        [self createItem:@"车速通" code:@"1005" selected:NO],
        [self createItem:@"约车" code:@"1006" selected:NO],
        [self createItem:@"二手车" code:@"1007" selected:NO],
        [self createItem:@"网约车" code:@"1008" selected:NO],
        [self createItem:@"新产品" code:@"1006" selected:NO],
        [self createItem:@"融资租赁" code:@"1007" selected:NO],
        [self createItem:@"以租代购" code:@"1008" selected:NO]
    ];
}

- (YQQSideFilterItem *)createItem:(NSString *)title code:(NSString *)code selected:(BOOL)selected {
    YQQSideFilterItem *item = [[YQQSideFilterItem alloc] init];
    item.title = title;
    item.code = code;
    item.selected = selected;
    item.reuseIdentifier = @"YQQCollectionViewNormalCell";
    return item;
}

@end
