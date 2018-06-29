//
//  MQSearchRelustController.m
//  MQReader
//
//  Created by Meng on 2018/4/29.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQSearchRelustController.h"
#import "MQBookSelfModel.h"

@interface MQSearchRelustController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableViews;

@end

@implementation MQSearchRelustController


-(UITableView *)tableViews{
    if (_tableViews == nil) {
        
        _tableViews = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableViews.delegate = self;
        _tableViews.dataSource = self;
        _tableViews.separatorColor = [UIColor greenColor];
        _tableViews.backgroundColor = [UIColor whiteColor];
        _tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViews.rowHeight = 100;
    }
    return _tableViews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableViews];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *DeleteMeCellIdentifier = @"DPLeftSlidingOperationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeleteMeCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DeleteMeCellIdentifier];
    }
    
    MQBookSelfModel *model = self.dataList[indexPath.row];
    cell.textLabel.text = model.BookName;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"cell with %ld",indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
