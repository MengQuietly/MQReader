//
//  MQRankingController.m
//  MQReader
//
//  Created by mengJing on 2018/5/8.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQRankingController.h"
#import "MQButtonCollectionCell.h"
#import "MQFindBookModel.h"
#import "NSString+Extension.h"

@interface MQRankingController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *leftContentView;
@property (nonatomic, strong) UITableView *rightContentView;
@property (nonatomic ,strong) NSMutableArray *leftList;
@property (nonatomic ,strong) NSMutableArray *rightList;

//当前被选中的ID值
@property (nonatomic ,assign) MQFindBookModel *curSelectModel;

//是否保持右边滚动时位置
@property(assign,nonatomic) BOOL isKeepScrollState;
@property(assign,nonatomic) BOOL isReturnLastOffset;
@property(assign,nonatomic) NSInteger selectIndex;


@end

@implementation MQRankingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"排行榜";
    
    self.view.backgroundColor = RGBRandom;
    
    [self setUpViews];
    
    [self requestFindBookWithRanking];
}

-(void) setUpViews {
    
    self.rightList = [[NSMutableArray alloc] init];
    self.leftList = [[NSMutableArray alloc] init];
    self.isReturnLastOffset=YES;
    //是否允许右位保持滚动位置
    self.isKeepScrollState=YES;
    self.selectIndex = 1;
    
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    titleView.backgroundColor = RGBRandom;
    [self.view addSubview:titleView];
    
    CGFloat leftY = CGRectGetMaxY(titleView.frame);
    self.leftContentView.y = leftY;
    self.leftContentView.height = USE_HEIGHT - leftY;
    [self.view addSubview:self.leftContentView];
    
    CGFloat rightX = CGRectGetMaxX(self.leftContentView.frame);
    CGFloat rightW = SCREEN_WIDTH - rightX;
    self.rightContentView.frame = CGRectMake(rightX, self.leftContentView.y, rightW, USE_HEIGHT - leftY);
    [self.view addSubview:self.rightContentView];
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.leftList.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MQButtonCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MQButtonCollectionCellID" forIndexPath:indexPath];
    
    if (self.leftList.count > 0) {
        MQFindBookModel *model = self.leftList[indexPath.item];
        cell.findBookModel = model;
        NSLog(@"---------%@-%@",cell.findBookModel,self.curSelectModel);
        cell.hasBeenSelected = (cell.findBookModel == self.curSelectModel);
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectIndex = indexPath.item;
    self.curSelectModel = self.leftList[indexPath.item];
    [collectionView reloadData];
    
    [self requestBooksListData];
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset = NO;
    
    if (self.isKeepScrollState) {
        
        [self.rightContentView scrollRectToVisible:CGRectMake(0, self.curSelectModel.offsetScorller, self.rightContentView.width, self.rightContentView.height) animated:NO];
        
    } else {
        
        [self.rightContentView scrollRectToVisible:CGRectMake(0, 0, self.rightContentView.width, self.rightContentView.height) animated:NO];
    }
    
//    NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:1];
//    [self.rightContentView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rightList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *DeleteMeCellIdentifier = @"DPLeftSlidingOperationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeleteMeCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DeleteMeCellIdentifier];
    }
//    if (self.searchController.active == YES) {
//        MQBookSelfModel *model = self.searchRelustList[indexPath.row];
//        cell.textLabel.text = model.BookName;
//    }else{
//        MQBookSelfModel *model = self.dataList[indexPath.row];
//        cell.textLabel.text = model.BookName;
//    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"cell with %ld",indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"--sel:%ld",indexPath.row);
    
}

#pragma mark---记录滑动的坐标(把右边滚动的Y值记录在列表的一个属性中)
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightContentView]) {
        self.isReturnLastOffset=YES;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([scrollView isEqual:self.rightContentView]) {
        MQFindBookModel * item=self.leftList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
        self.isReturnLastOffset=NO;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.rightContentView] && self.isReturnLastOffset) {
        MQFindBookModel * item=self.leftList[self.selectIndex];
        item.offsetScorller=scrollView.contentOffset.y;
    }
}

-(UITableView *)rightContentView{
    if (_rightContentView == nil) {
        
        _rightContentView = [[UITableView alloc] init];
        _rightContentView.delegate = self;
        _rightContentView.dataSource = self;
        _rightContentView.backgroundColor = [UIColor yellowColor];
//        _rightContentView.frame = CGRectMake(0, 44, SCREEN_WIDTH-150, USE_HEIGHT - tableViewMaxY - 50);
        _rightContentView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _rightContentView.rowHeight = 100;
    }
    return _rightContentView;
}

-(UICollectionView *)leftContentView{
    if (_leftContentView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.5f;
        layout.itemSize = CGSizeMake(100, 80);
        
        _leftContentView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, self.view.height) collectionViewLayout:layout];
        [_leftContentView registerClass:[MQButtonCollectionCell class] forCellWithReuseIdentifier:@"MQButtonCollectionCellID"];
        _leftContentView.backgroundColor = [UIColor whiteColor]; // shite
        _leftContentView.showsHorizontalScrollIndicator = NO;
        _leftContentView.showsVerticalScrollIndicator = YES;
        _leftContentView.dataSource = self;
        _leftContentView.delegate = self;
    }
    return _leftContentView;
}

#pragma mark - Network Request
#pragma mark  找书-排行榜

- (void)requestFindBookWithRanking {
    
    __weak typeof(self) weakSelf = self;
    [MQNetworking requestRankWithFindBook:^(id responseObject) {
        //        NSLog(@"-----%@",responseObject);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        if ([responseObject[@"ok"] integerValue] == 1) {
            
            NSArray *epubArr = [MQFindBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"epub"]];
            if (epubArr.count > 0) {
                
                NSLog(@"----------------epubArr--------------");
                for (MQFindBookModel *model in epubArr) {
                    NSLog(@"shortTitle=%@,title=%@",model.shortTitle,model.title);
                    //                    NSLog(@"_id=%@,shortTitle=%@,title=%@",model._id,model.shortTitle,model.title);
                }
            }
            
            
            NSArray *femaleArr = [MQFindBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"female"]];
            if (femaleArr.count > 0) {
                
                strongSelf.leftList = [NSMutableArray arrayWithArray:femaleArr];
                [strongSelf.leftContentView reloadData];
                
                NSLog(@"----------------femaleArr--------------");
                for (MQFindBookModel *model in femaleArr) {
                    NSLog(@"shortTitle=%@,title=%@",model.shortTitle,model.title);
                    //NSLog(@"_id=%@,shortTitle=%@,title=%@,monthRank=%@,totalRank=%@",model._id,model.shortTitle,model.title,model.monthRank,model.totalRank);
                    
                }
            }
            
            NSArray *maleArr = [MQFindBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"male"]];
            if (maleArr.count > 0) {
                strongSelf.rightList = [NSMutableArray arrayWithArray:maleArr];
                [strongSelf.rightContentView reloadData];
                
                NSLog(@"----------------maleArr--------------");
                for (MQFindBookModel *model in maleArr) {
                    NSLog(@"shortTitle=%@,title=%@",model.shortTitle,model.title);
                    //NSLog(@"_id=%@,shortTitle=%@,title=%@,monthRank=%@,totalRank=%@",model._id,model.shortTitle,model.title,model.monthRank,model.totalRank);
                    
                }
            }
            
            NSArray *pictureArr = [MQFindBookModel mj_objectArrayWithKeyValuesArray:responseObject[@"picture"]];
            if (pictureArr.count > 0) {
                NSLog(@"----------------pictureArr--------------");
                for (MQFindBookModel *model in pictureArr) {
                    NSLog(@"shortTitle=%@,title=%@",model.shortTitle,model.title);
                    //NSLog(@"_id=%@,shortTitle=%@,title=%@,monthRank=%@,totalRank=%@",model._id,model.shortTitle,model.title,model.monthRank,model.totalRank);
                    
                }
            }
            
            if (self.leftList.count > 0) {
                self.curSelectModel=[self.leftList objectAtIndex:self.selectIndex];
                [self.leftContentView selectItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
                [self.leftContentView reloadData];
                
                //右边数据加载
                [self requestBooksListData];
            }
        }
        
        
        
    } fail:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        [strongSelf.view showHUDServerError];
    }];
    
}

#pragma mark  找书-排行榜
-(void) requestBooksListData {
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
