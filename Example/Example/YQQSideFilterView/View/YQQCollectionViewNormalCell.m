//
//  YQQCollectionViewNormalCell.m
//  Example
//
//  Created by zhuyi on 2020/10/19.
//

#import "YQQCollectionViewNormalCell.h"
#import "YQQSideFilterItem.h"

@interface YQQCollectionViewNormalCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation YQQCollectionViewNormalCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _titleLabel.layer.cornerRadius = 14;
    _titleLabel.layer.masksToBounds = YES;
}

- (void)setItem:(YQQSideFilterItem *)item {
    _item = item;
    _titleLabel.text = item.title;
    if (item.selected) {
        _titleLabel.textColor = [UIColor colorWithRed:26/255.0 green:203/255.0 blue:151/255.0 alpha:1.0];
        _titleLabel.backgroundColor = [UIColor colorWithRed:26/255.0 green:203/255.0 blue:151/255.0 alpha:0.1];
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.borderColor = [UIColor colorWithRed:26/255.0 green:203/255.0 blue:151/255.0 alpha:1.0].CGColor;
    } else {
        _titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
        _titleLabel.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        _titleLabel.layer.borderWidth = 0;
    }
}

@end
