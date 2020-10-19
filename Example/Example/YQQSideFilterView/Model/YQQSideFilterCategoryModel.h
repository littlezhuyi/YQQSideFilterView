//
//  YQQSideFilterModel.h
//  Example
//
//  Created by zhuyi on 2020/10/17.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YQQSideFilterCategoryModelType) {
    YQQSideFilterCategoryModelTypeNone,
    YQQSideFilterCategoryModelTypePush,
    YQQSideFilterCategoryModelTypeSwitch
};

NS_ASSUME_NONNULL_BEGIN

@interface YQQSideFilterCategoryModel : NSObject

@property (nonatomic, assign) YQQSideFilterCategoryModelType type;

@property (nonatomic, copy) NSString *classification;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, assign) BOOL isOpen;

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *headerReuseIdentifier;

@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, copy) NSString *footerReuseIdentifier;

@property (nonatomic, assign) CGFloat footerHeight;

@end

NS_ASSUME_NONNULL_END
