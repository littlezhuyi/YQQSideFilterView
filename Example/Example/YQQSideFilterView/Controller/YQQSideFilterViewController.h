//
//  YQQSideFilterViewController.h
//  Example
//
//  Created by zhuyi on 2020/10/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YQQSideFilterViewController : UIViewController

@property (nonatomic, assign) CGFloat sideSlipLeading;

@property (nonatomic, strong) NSArray *dataArray;

- (void)show;

- (void)close;

@end

NS_ASSUME_NONNULL_END
