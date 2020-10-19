//
//  YQQCollectionSwitchReusableHeaderView.m
//  Example
//
//  Created by zhuyi on 2020/10/19.
//

#import "YQQCollectionSwitchReusableHeaderView.h"
#import "YQQSideFilterCategoryModel.h"

@interface YQQCollectionSwitchReusableHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;

@end

@implementation YQQCollectionSwitchReusableHeaderView

@synthesize categoryModel = _categoryModel;

- (IBAction)actiom:(UIButton *)sender {
    if (_categoryModel.type == YQQSideFilterCategoryModelTypeSwitch) {
        _categoryModel.isOpen = !_categoryModel.isOpen;
        if ([self.delegate respondsToSelector:@selector(reusableView:didSelectModel:)]) {
            [self.delegate reusableView:self didSelectModel:_categoryModel];
        }
    }
}

- (void)setCategoryModel:(YQQSideFilterCategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    _titleLabel.text = _categoryModel.classification;
    if (_categoryModel.type == YQQSideFilterCategoryModelTypeSwitch) {
        _arrow.hidden = NO;
        if (_categoryModel.isOpen) {
            _arrow.image = [UIImage imageNamed:@"crm_arrowUp_gray"];
        } else {
            _arrow.image = [UIImage imageNamed:@"crm_arrowDown_gray"];
        }
    } else {
        _arrow.hidden = YES;
    }
}

@end
