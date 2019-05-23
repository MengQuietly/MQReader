//
//  MQCategoryController.m
//  MQReader
//
//  Created by mengY on 2019/5/16.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "MQCategoryController.h"
#import <BAKit_BAGridView.h>
#import "MQCategoryModel.h"
#import "MQCategoryDetailController.h"

@interface MQCategoryController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableViews;

@property (nonatomic ,strong) NSMutableArray *GGCategoryList;
@property (nonatomic ,strong) NSMutableArray *MMCategoryList;
@property (nonatomic ,strong) NSMutableArray *IMGCategoryList;
@property (nonatomic ,strong) NSMutableArray *OtherCategoryList;

@end

@implementation MQCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"分类";
    
    self.view.backgroundColor = RGBRandom;
    [self setUpViews];
    [self requestCatego];
}

-(void) setUpViews {
    self.GGCategoryList = [[NSMutableArray alloc] init];
    self.MMCategoryList = [[NSMutableArray alloc] init];
    self.IMGCategoryList = [[NSMutableArray alloc] init];
    self.OtherCategoryList = [[NSMutableArray alloc] init];
    [self.view addSubview:self.tableViews];
}

-(UITableView *)tableViews{
    if (_tableViews == nil) {
        _tableViews = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableViews.delegate = self;
        _tableViews.dataSource = self;
        _tableViews.separatorColor = RGBGray;
        _tableViews.backgroundColor = [UIColor whiteColor];
//        _tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViews.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tableViews.rowHeight = 50;
        _tableViews.sectionHeaderHeight = 35;
        _tableViews.sectionFooterHeight = 0.01;
    }
    return _tableViews;
}

#pragma mark------tableViews的代理方法
#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return self.GGCategoryList.count;
    } else if (section == 1) {
        return self.MMCategoryList.count;
    } else if (section == 2) {
        return self.IMGCategoryList.count;
    } else {
        return self.OtherCategoryList.count;
    }
    return 0;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"男生";
    } else if (section == 1) {
        return @"女生";
    }  else if (section == 2) {
        return @"图片";
    } else {
        return @"出版";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    if (indexPath.section == 0) {
        MQCategoryModel *model = self.GGCategoryList[indexPath.row];
        cell.textLabel.text=model.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu 本", model.bookCount];
    } else if (indexPath.section == 1) {
        MQCategoryModel *model = self.MMCategoryList[indexPath.row];
        cell.textLabel.text=model.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu 本", model.bookCount];
    } else if (indexPath.section == 2) {
        MQCategoryModel *model = self.IMGCategoryList[indexPath.row];
        cell.textLabel.text=model.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu 本", model.bookCount];
    } else {
        MQCategoryModel *model = self.OtherCategoryList[indexPath.row];
        cell.textLabel.text=model.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu 本", model.bookCount];
    }
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MQCategoryDetailController *categoryDetailVC = [[MQCategoryDetailController alloc] init];
    if (indexPath.section == 0) {
        categoryDetailVC.genderStr = @"male";
        MQCategoryModel *model = self.GGCategoryList[indexPath.row];
        categoryDetailVC.majorStr = model.name;
    } else if (indexPath.section == 1) {
       categoryDetailVC.genderStr = @"female";
        MQCategoryModel *model = self.MMCategoryList[indexPath.row];
        categoryDetailVC.majorStr = model.name;
    } else if (indexPath.section == 2) {
       categoryDetailVC.genderStr = @"picture";
        MQCategoryModel *model = self.IMGCategoryList[indexPath.row];
        categoryDetailVC.majorStr = model.name;
    } else {
        categoryDetailVC.genderStr = @"press";
        MQCategoryModel *model = self.OtherCategoryList[indexPath.row];
        categoryDetailVC.majorStr = model.name;
    }
    
    [self.navigationController pushViewController:categoryDetailVC animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:RGBGray];
    [header.textLabel setFont:[UIFont systemFontOfSize:20]];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    v.backgroundColor = RGBGray;
    return v;
}

#pragma mark - Network Request
#pragma mark  分类
- (void)requestCatego {
    
    __weak typeof(self) weakSelf = self;
    [MQNetworking requestCategoryWithSuccessBook:^(id responseObject) {
        NSLog(@"%ss 获取的数据==========%@",__func__, [[NSString alloc] stringJsonWithLocale:responseObject]);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"ok"] integerValue] == 1) {
            NSArray *maleArr = [MQCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"male"]];
            self.GGCategoryList = [NSMutableArray arrayWithArray:maleArr];
            
            NSArray *femaleArr = [MQCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"female"]];
            self.MMCategoryList = [NSMutableArray arrayWithArray:femaleArr];
  
            NSArray *pictureArr = [MQCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"picture"]];
            self.IMGCategoryList = [NSMutableArray arrayWithArray:pictureArr];
          
            
            NSArray *pressArr = [MQCategoryModel mj_objectArrayWithKeyValuesArray:responseObject[@"press"]];
            
            self.OtherCategoryList =[NSMutableArray arrayWithArray:pressArr];
            
            [self.tableViews reloadData];
            
//            if (self.leftList.count > 0) {
//                self.curSelectModel=[self.leftList objectAtIndex:self.selectIndex];
//                [self.leftContentView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
//                [self.leftContentView reloadData];
//
//                //右边数据加载
//                [self requestBooksListData];
//            }
        }
        
        
        
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        [strongSelf.view showHUDServerError];
    }];
    
}

@end
