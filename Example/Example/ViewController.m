//
//  ViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/17.
//

#import "ViewController.h"
#import "YQQSideFilterViewController.h"
#import "YQQSideFilterItem.h"
#import "YQQSideFilterCategoryModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)show:(UIButton *)sender {
    YQQSideFilterViewController *filter = [YQQSideFilterViewController new];
    filter.dataArray = [self createGroupModel];
    [filter show];
}

- (NSArray *)createGroupModel {
    return @[[self createFilterModel:@"机动车所有人" subTitle:@"首汽租赁有限责任公司齐齐哈尔分公司" open:YES type:YQQSideFilterCategoryModelTypePush],
             [self createFilterModel:@"机动车使用人" subTitle:@"首汽租赁有限责任公司北京分公司" open:YES type:YQQSideFilterCategoryModelTypePush],
             [self createFilterModel:@"车态" subTitle:@"" open:YES type:YQQSideFilterCategoryModelTypeSwitch],
             [self createFilterModel:@"租赁用途" subTitle:@"" open:YES type:YQQSideFilterCategoryModelTypeNone],
             [self createFilterModel:@"机动车所有人" subTitle:@"首汽租赁有限责任公司齐齐哈尔分公司" open:YES type:YQQSideFilterCategoryModelTypePush],
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
