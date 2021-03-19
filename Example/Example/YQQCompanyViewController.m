//
//  YQQCompanyViewController.m
//  Example
//
//  Created by zhuyi on 2020/10/19.
//

#import "YQQCompanyViewController.h"

@interface YQQCompanyViewController ()

@end

@implementation YQQCompanyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
