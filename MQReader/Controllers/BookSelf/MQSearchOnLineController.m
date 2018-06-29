//
//  MQSearchOnLineController.m
//  MQReader
//
//  Created by Meng on 2018/4/28.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQSearchOnLineController.h"
#import "UIImage+Extension.h"
#import "MQBookSelfModel.h"

@interface MQSearchOnLineController ()<UISearchBarDelegate,UISearchResultsUpdating,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UISearchController *searchController;

@property (nonatomic, strong) UITableView *tableViews;

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,strong) NSMutableArray *searchRelustList;

/** 搜索框背景颜色 */
@property (nonatomic, strong) UIImage *searchBarBgImg;
/** 搜索框背景颜色 */
@property (nonatomic, strong) UIImage *searchFieldBgImg;

@end

@implementation MQSearchOnLineController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (!self.searchController.searchBar.isFirstResponder) {
        [self.searchController.searchBar becomeFirstResponder];
    }

    // 跳转到新页面使searchBar成为第一响应者的时间点问题:当页面出现后再延迟设置
//    [self performSelector:@selector(showKeyboard) withObject:nil afterDelay:0];
}

- (void)showKeyboard {
    [self.searchController.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchController.searchBar resignFirstResponder];
}

- (void)viewDidLayoutSubviews{
    
    if (self.searchController.active == YES) {
        [self.tableViews setFrame:CGRectMake(0, 20, self.view.width, self.view.height - 20)];
    }else{
        self.tableViews.frame = self.view.bounds;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = RGBRandom;
    
    self.navigationItem.title = @"搜索";
    
    if (@available(iOS 11.0, *)) {
        self.tableViews.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.definesPresentationContext = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.dataList = [NSMutableArray array];
    
    
    [self setUpViews];
}

-(void) setUpViews {

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 50, 40);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
    backBtn.adjustsImageWhenHighlighted = NO;
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    for (int i = 1; i < 30; i++) {
        MQBookSelfModel *model = [[MQBookSelfModel alloc] init];
        if (i == 10) {
            model.BookName = [NSString stringWithFormat:@"李四 %d 号",i];
        }else{
        model.BookName = [NSString stringWithFormat:@"zhangsan %d 号",i];
        }
        model.BookId = @(i);
        
        [self.dataList addObject:model];
    }
    
    [self.view addSubview:self.tableViews];

    self.tableViews.backgroundColor = RGBRandom;
    
}

#pragma mark - Action

- (void)backBtnClick {
    [self.searchController.searchBar resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
}



#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__func__);
    
    self.searchController.searchBar.backgroundImage = self.searchBarBgImg;
    [self.searchController.searchBar resignFirstResponder];
    
    
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    self.searchController.searchBar.backgroundImage = self.searchFieldBgImg;

}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    //改变SearchBar 背景颜色
    self.searchController.searchBar.backgroundImage = self.searchBarBgImg;
    [self.searchController.searchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"%s",__func__);
    //改变SearchBar 背景颜色
    self.searchController.searchBar.backgroundImage = self.searchBarBgImg;
//    self.searchController.searchBar.showsCancelButton = YES;
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"%s",__func__);
//    NSString *inputStr = searchText;
//    [self.searchRelustList removeAllObjects];
//    for (MQBookSelfModel *model in self.dataList) {
//        if ([model.BookName.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
//            [self.searchRelustList addObject:model];
//        }
//    }
//    [self.tableViews reloadData];
}

#pragma mark - UISearchResultsUpdating  (which you use ,which you choose!!)
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"%s",__func__);
    // update the filtered array based on the search text
    NSString *searchStr = searchController.searchBar.text;
    
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    /*
     ** BEGINSWITH ： 搜索结果以搜索框里的字符开头的
     ** ENDSWITH ： 搜索结果以搜索框里的字符结尾的
     ** CONTAINS ： 搜索结果的字符串包含搜索框里的字符
     ** [c]不区分大小写,[d]不区分发音符号即没有重音符号,[cd]既不区分大小写，也不区分发音符号。
     link:https://blog.csdn.net/daiyelang/article/details/18546405
     */
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",searchStr];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"BookName contains [cd] %@",searchStr];
//    for(MQBookSelfModel *model in self.dataList){
//        if([predicate evaluateWithObject:model]){
//            //判断指定的对象是否满足
//        }
//    }
    if (self.searchRelustList != nil) {
        [self.searchRelustList removeAllObjects];
    }
    NSLog(@"---%ld ge",self.searchRelustList.count);
    self.searchRelustList = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:predicate]];
    
    if (searchStr.length == 0) {
        [self.searchRelustList removeAllObjects];
    }
    [self.tableViews reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.searchController.active == YES) {
        return self.searchRelustList.count;
    }else{
        return self.dataList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *DeleteMeCellIdentifier = @"DPLeftSlidingOperationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeleteMeCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:DeleteMeCellIdentifier];
    }
    if (self.searchController.active == YES) {
        MQBookSelfModel *model = self.searchRelustList[indexPath.row];
        cell.textLabel.text = model.BookName;
    }else{
        MQBookSelfModel *model = self.dataList[indexPath.row];
        cell.textLabel.text = model.BookName;
    }
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"cell with %ld",indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.searchController.active == YES) {
        MQBookSelfModel *model = self.searchRelustList[indexPath.row];
        NSLog(@"%@", model.BookName);
    }else {
        MQBookSelfModel *model = self.dataList[indexPath.row];
        NSLog(@"%@", model.BookName);
    }
    
    // 停止搜索
//    self.searchController.active = NO;
    
}

#pragma mark - 懒加载

-(UIImage *)searchBarBgImg {
    if (_searchBarBgImg == nil) {
        _searchBarBgImg = [UIImage imageWithColor:RGB(242, 242, 243) size:CGSizeMake(200, 26)];
    }
    return _searchBarBgImg;
}

-(UIImage *)searchFieldBgImg {
    if (_searchFieldBgImg == nil) {
        _searchFieldBgImg = [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(200, 26)];
    }
    return _searchFieldBgImg;
}


-(UITableView *)tableViews{
    if (_tableViews == nil) {
        
        _tableViews = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableViews.delegate = self;
        _tableViews.dataSource = self;
        _tableViews.backgroundColor = [UIColor whiteColor];
//        _tableViews.frame = CGRectMake(0, tableViewMaxY, APP_WIDTH, USE_HEIGHT - tableViewMaxY - 50);
        _tableViews.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViews.rowHeight = 80;
        _tableViews.tableHeaderView = self.searchController.searchBar;
    }
    return _tableViews;
}

- (UISearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchBar.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.placeholder = @"搜索本地或书城";
        // 搜索时，背景变暗色
        _searchController.dimsBackgroundDuringPresentation = NO;
        //搜索时，背景变模糊
//        _searchController.obscuresBackgroundDuringPresentation = YES;
        // 点击搜索的时候,是否隐藏导航栏
        _searchController.hidesNavigationBarDuringPresentation = YES;
        [_searchController.searchBar sizeToFit];
        UIOffset offset = {5,0};
        _searchController.searchBar.searchTextPositionAdjustment = offset;
        
        //设置背景图是为了去掉上下黑线
        _searchController.searchBar.backgroundImage = self.searchBarBgImg;
        
        [_searchController.searchBar setSearchFieldBackgroundImage:self.searchFieldBgImg forState:UIControlStateNormal];
        _searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
        _searchController.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;//关闭提示
        _searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;//关闭自动首字母大写
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor lightGrayColor]];
        [self setSearchBarTextField];
    }
    return _searchController;
}

//设置字体颜色,文本框的放大镜
-(void)setSearchBarTextField{
    UITextField *searchField = [self.searchController.searchBar valueForKey:@"_searchField"];
    if (searchField) {
        searchField.textColor = [UIColor blackColor]; //字体颜色
        
        NSLog(@"nononono---%@",searchField.leftView);
        
        if ([searchField.leftView isKindOfClass:[UIImageView class]]) {
            UIImageView *searchIcon = (UIImageView *) searchField.leftView;
            searchIcon.image = [UIImage imageNamed:@"search_normal"];
        }
    
//    //修改左边的放大镜
//    UIImage *image = [UIImage imageNamed:@"add_selected"];
//    UIImageView *iconView = [[UIImageView alloc] initWithImage:image];
//    iconView.frame = CGRectMake(0, 0, image.size.width , image.size.height);
//    searchField.leftView = iconView;
        
        searchField.layer.cornerRadius = 8.0f;
        searchField.layer.borderColor = RGB(247, 75, 31).CGColor;
        searchField.layer.borderWidth = 0.5;
        searchField.layer.masksToBounds = YES;
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ((self.searchController.active == YES) && self.searchController.searchBar.isFirstResponder) {
        [self.searchController.searchBar resignFirstResponder];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
