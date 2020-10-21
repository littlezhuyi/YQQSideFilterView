//
//  YQQSideFilterViewController.h
//  Example
//
//  Created by zhuyi on 2020/10/17.
//

#import <UIKit/UIKit.h>
@class YQQSideFilterViewController;

typedef NS_ENUM(NSUInteger, YQQSideFilterViewControllerActionType) {
    YQQSideFilterViewControllerActionTypeReset,
    YQQSideFilterViewControllerActionTypeConfirm
};

@protocol YQQSideFilterViewControllerDelegate <NSObject>

- (void)sideFilterViewController:(YQQSideFilterViewController *_Nullable)sideFilterViewController didSelectActionType:(YQQSideFilterViewControllerActionType)actionType;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YQQSideFilterViewController : UIViewController

@property (nonatomic, weak) id<YQQSideFilterViewControllerDelegate> delegate;

@property (nonatomic, assign) CGFloat sideSlipLeading;

@property (nonatomic, strong) NSArray *dataArray;

- (void)show;

- (void)close;

@end

NS_ASSUME_NONNULL_END
