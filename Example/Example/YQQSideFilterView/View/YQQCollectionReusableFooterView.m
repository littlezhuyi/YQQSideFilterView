//
//  YQQCollectionReusableFooterView.m
//  Example
//
//  Created by zhuyi on 2020/10/19.
//

#import "YQQCollectionReusableFooterView.h"
#import "YQQSideFilterCategoryModel.h"

@implementation YQQCollectionReusableFooterView

@synthesize categoryModel = _categoryModel;

- (void)setCategoryModel:(YQQSideFilterCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
}

@end
