//
//  MQCategoryDetailController.m
//  MQReader
//
//  Created by mengY on 2019/5/20.
//  Copyright © 2019 Meng. All rights reserved.
//

#import "MQCategoryDetailController.h"
#import <JXCategoryView.h>

//JXCategoryListContainerViewDelegate
@interface MQCategoryDetailController ()<JXCategoryViewDelegate>

@property (nonatomic, strong) NSString *typeStr;
@property (nonatomic, strong) NSString *minorStr;
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic ,copy) NSArray *typeShowList;
@property (nonatomic ,copy) NSArray *typeHideList;
@property (nonatomic ) NSInteger currentSelType;

@end

@implementation MQCategoryDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [[NSString alloc] initWithFormat:@"%@-%@", self.genderStr, self.majorStr];
    
    self.view.backgroundColor = RGBRandom;
    self.currentSelType = 0;
    [self setUpViews];
}

-(void) setUpViews {
    self.typeShowList = @[@"热门", @"新书", @"好评", @"完结", @"包月"];
    self.typeHideList = @[@"hot", @"new", @"repulation", @"over", @"month"];
    
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    self.categoryView.delegate = self;
    [self.view addSubview:self.categoryView];
    
    self.categoryView.titles = self.typeShowList;
    self.categoryView.defaultSelectedIndex = self.currentSelType;
    self.categoryView.titleColorGradientEnabled = YES;
  
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = [UIColor redColor];
    lineView.indicatorLineWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    
    

//    self.listContainerView = [[JXCategoryListContainerView alloc] initWithDelegate:self];
//    self.listContainerView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height - 50);
//    self.listContainerView.defaultSelectedIndex = self.currentSelType;
//    [self.view addSubview:self.listContainerView];
//    
//    self.categoryView.contentScrollView = self.listContainerView.scrollView;
 
}


#pragma mark - JXCategoryViewDelegate
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    
}

//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index {
}

//滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index {
}

//正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio {
}

//自定义contentScrollView点击选中切换效果
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index {
}

//#pragma mark - JXCategoryListContainerViewDelegate
//- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
////    LoadDataListContainerListViewController *listVC = [[LoadDataListContainerListViewController alloc] init];
////    listVC.naviController = self.navigationController;
////    return listVC;
//    MQCategoryDetailController *vc = [[MQCategoryDetailController alloc] init];
//    return vc;
//}
//
//- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
////    return self.titles.count;
//    return 5;
//}


@end
