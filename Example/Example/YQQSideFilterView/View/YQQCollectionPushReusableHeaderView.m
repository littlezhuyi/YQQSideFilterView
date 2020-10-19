//
//  YQQCollectionPushReusableHeaderView.m
//  Example
//
//  Created by zhuyi on 2020/10/19.
//

#import "YQQCollectionPushReusableHeaderView.h"
#import "YQQSideFilterCategoryModel.h"

@interface YQQCollectionPushReusableHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end

@implementation YQQCollectionPushReusableHeaderView

@synthesize categoryModel = _categoryModel;

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(reusableView:didSelectModel:)]) {
        [self.delegate reusableView:self didSelectModel:_categoryModel];
    }
}

- (void)setCategoryModel:(YQQSideFilterCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    _titleLabel.text = _categoryModel.classification;
    _subTitleLabel.text = _categoryModel.subTitle;
}

@end
