//
//  MQBaseController.m
//  MQReader
//
//  Created by Meng on 2018/4/28.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQBaseController.h"

@interface MQBaseController ()

@end

@implementation MQBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void) setUpView {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 100, 40);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setTitle:@"  返回" forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"shanxuanfanhui"] forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"shanxuanfanhui"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = item;
}
/*
- (void)back{
    [self popViewControllerAnimated:YES];
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
