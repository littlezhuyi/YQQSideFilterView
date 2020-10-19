//
//  YQQSideFilterItem.h
//  Example
//
//  Created by zhuyi on 2020/10/17.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YQQSideFilterItemType) {
    YQQSideFilterItemTypeNormal,
    YQQSideFilterItemTypeCompany
};

NS_ASSUME_NONNULL_BEGIN

@interface YQQSideFilterItem : NSObject

@property (nonatomic, assign) YQQSideFilterItemType type;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *subTitle;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, copy) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
