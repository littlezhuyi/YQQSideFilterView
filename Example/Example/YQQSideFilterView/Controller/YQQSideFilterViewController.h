//
//  YQQSideFilterViewController.h
//  Example
//
//  Created by 朱逸 on 2021/3/19.
//

#import <UIKit/UIKit.h>
@class YQQSideFilterViewController;

typedef NS_ENUM(NSUInteger, YQQSideFilterViewControllerActionType) {
    YQQSideFilterViewControllerActionTypeReset,
    YQQSideFilterViewControllerActionTypeConfirm
};

@protocol YQQSideFilterViewControllerDataSource <NSObject>

@required
- (UICollectionViewCell *_Nullable)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController cellForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (NSInteger)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController numberOfItemsInSection:(NSInteger)section;

@optional

- (UIButton *_Nullable)confirmButtonForSideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController;
- (UIButton *_Nullable)resetButtonForSideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController;
- (UICollectionReusableView *_Nullable)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController viewForSupplementaryElementOfKind:(NSString *_Nullable)kind atIndexPath:(NSIndexPath *_Nullable)indexPath;
- (NSInteger)numberOfSectionsInsideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController;

- (CGSize)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController sizeForItemAtIndexPath:(NSIndexPath *_Nullable)indexPath;
- (UIEdgeInsets)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController insetForSectionAtIndex:(NSInteger)section;
- (CGFloat)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGSize)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController referenceSizeForHeaderInSection:(NSInteger)section;
- (CGSize)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController referenceSizeForFooterInSection:(NSInteger)section;

@end

@protocol YQQSideFilterViewControllerDelegate <NSObject>

@optional
- (void)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController didSelectActionType:(YQQSideFilterViewControllerActionType)actionType;
- (void)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController didSelectItemAtIndexPath:(NSIndexPath *_Nullable)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YQQSideFilterViewController : UIViewController

@property (nonatomic, weak) id<YQQSideFilterViewControllerDelegate> delegate;

@property (nonatomic, weak) id<YQQSideFilterViewControllerDataSource> dataSource;

@property (nonatomic, assign) CGFloat sideSlipLeading;

@property (nonatomic, assign) CGFloat bottomButtonContainerHeight;

@property (nonatomic, strong) NSArray *dataArray;

- (void)show;
- (void)close;
- (void)reloadData;
- (void)pushViewController:(UIViewController *)controller;

- (void)registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(nullable UINib *)nib forCellWithReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(nullable Class)viewClass forSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(nullable UINib *)nib forSupplementaryViewOfKind:(NSString *)kind withReuseIdentifier:(NSString *)identifier;
- (__kindof UICollectionReusableView *)dequeueReusableSupplementaryViewOfKind:(NSString *)elementKind withReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(nonnull NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
