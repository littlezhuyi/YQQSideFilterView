//
//  YQQCollectionBaseReusableView.h
//  Example
//
//  Created by zhuyi on 2020/10/19.
//

#import <UIKit/UIKit.h>
@class YQQSideFilterCategoryModel;
@class YQQCollectionBaseReusableView;

@protocol YQQCollectionBaseReusableViewDelegate <NSObject>

- (void)reusableView:(YQQCollectionBaseReusableView *_Nullable)reusableView didSelectModel:(YQQSideFilterCategoryModel *_Nullable)categoryModel;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YQQCollectionBaseReusableView : UICollectionReusableView

@property (nonatomic, strong) YQQSideFilterCategoryModel *categoryModel;

@property (nonatomic, weak) id<YQQCollectionBaseReusableViewDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

NS_ASSUME_NONNULL_END
