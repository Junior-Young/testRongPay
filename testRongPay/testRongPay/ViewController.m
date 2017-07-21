//
//  ViewController.m
//  testRongPay
//
//  Created by 杨俊杰 on 2017/7/17.
//  Copyright © 2017年 rongcapital. All rights reserved.
//

#import "ViewController.h"
#import "rongPaySDK.framework/Headers/RPayManager.h"
// 动态获取屏幕宽高
#define YScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define YScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"融数钱包";
    [self initRongPay];
    [self setupTextField];
    [self setupCounterButton];
}

- (void)initRongPay {
    //初始化融数钱包
    [RPayManager defaultManager];
}

- (void)setupTextField {
    NSArray *textArray = @[@"订单标题", @"订单详情", @"订单号",  @"金额(分)",  @"钱包客户号", @"操作员号"];
    NSArray *detailArray = @[@"培训课程费用", @"健身培训课程费用 - 瑜伽课程，总共三节课程。", @"141344534354524560",  @"1",  @"71780006179AQWTCB", @"0313"];
    for (int i = 0; i < textArray.count; i++) {
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(15, 100 + 50*i, 100, 20)];
        titleLable.font = [UIFont boldSystemFontOfSize:16];
        titleLable.text = textArray[i];
        [self.view addSubview:titleLable];
        
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLable.frame), 70 + 50*i, YScreenWidth - 130, 50)];
        textField.placeholder = textArray[i];
        textField.font = [UIFont systemFontOfSize:16];
        textField.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        [self.view addSubview:textField];
        if (i == 3) {
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }
        textField.text = detailArray[i];
        textField.tag = 100 + i;
        
        
        UIView *segmentView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(textField.frame), CGRectGetMaxY(textField.frame) + 4, CGRectGetWidth(textField.frame), 0.6)];
        segmentView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:segmentView];
    }
    
}


- (void)setupCounterButton {
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(0, YScreenHeight - 48, YScreenWidth, 48);
    [button setBackgroundColor:[UIColor grayColor]];
    [button setTitle:@"收银台" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(showCounter) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)showCounter {
    UITextField *textField = [self.view viewWithTag:100];
    NSString *title = textField.text;
    UITextField *textField1 = [self.view viewWithTag:101];
    NSString *details = textField1.text;
    UITextField *textField2 = [self.view viewWithTag:102];
    NSString *orderId = textField2.text;
    UITextField *textField3 = [self.view viewWithTag:103];
    NSInteger amount = [textField3.text integerValue];
    UITextField *textField4 = [self.view viewWithTag:104];
    NSString *customerNo = textField4.text;
    UITextField *textField5 = [self.view viewWithTag:105];
    NSString *operator = textField5.text;
    
    //调用融数钱包收银台
    [RPayManager pushCashierWithNavigationController:self.navigationController title:title details:details orderId:orderId amount:amount customerNo:customerNo operator:operator callBackBlock:^(NSString *result) {
        NSLog(@"%@", result);
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
