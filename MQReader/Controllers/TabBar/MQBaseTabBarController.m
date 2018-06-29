//
//  MQBaseTabBarController.m
//  MQReader
//
//  Created by Meng on 2018/4/26.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import "MQBaseTabBarController.h"
#import "MQBookSelfController.h"
#import "MQBookCityController.h"
#import "MQFindController.h"
#import "MQMineController.h"
#import "KLTNavigationController.h"

@interface MQBaseTabBarController ()<UITabBarControllerDelegate>

@property (strong,nonatomic) UINavigationController *bookSelfNav;
@property (strong,nonatomic) UINavigationController *bookCityNav;
@property (strong,nonatomic) UINavigationController *findNav;
@property (strong,nonatomic) UINavigationController *mineNav;

@property (nonatomic) NSTimer *refreshUnreadCountTimer;

@end

@implementation MQBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNoticeCount:) name:UpdateNoticeCount object:nil];
    
    self.delegate = self;
    self.view.backgroundColor = RGB(242, 242, 242);
    
    [self setupTabBarItems];
    [self setupTabBarStyle];
}

- (void)setupTabBarStyle {
    // for shouldSelectViewController, enabling animation for tabbar item clicked.
    [self setDelegate:self];
    
    // White background
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
}

#pragma mark - 修改通知的数量，小红点
- (void)updateNoticeCount:(NSNotification *)notification {
    NSNumber *unreadCount = notification.userInfo[@"unreadCount"];
    self.mineNav.tabBarItem.badgeValue = unreadCount.integerValue > 0 ? unreadCount.stringValue : nil;
}

- (void) setupTabBarItems {
    
    self.bookSelfNav = [self addTabBarChildVCWithVCClass:[MQBookSelfController class] VCTitle:@"书架" VCIconName:@"bookself"];
    self.bookCityNav =[self addTabBarChildVCWithVCClass:[MQBookCityController class] VCTitle:@"书城" VCIconName:@"bookcity"];
    self.findNav =[self addTabBarChildVCWithVCClass:[MQFindController class] VCTitle:@"发现" VCIconName:@"find"];
    self.mineNav =[self addTabBarChildVCWithVCClass:[MQMineController class] VCTitle:@"我的" VCIconName:@"mine"];
    
    NSArray *controllers = @[self.bookSelfNav, self.bookCityNav, self.findNav, self.mineNav];
    [self setViewControllers:controllers];
}

-(UINavigationController *) addTabBarChildVCWithVCClass:(Class) VCClass VCTitle:(NSString *) VCTitle VCIconName:(NSString *) VCIconName {
    
    NSString *normalImg = [NSString stringWithFormat:@"%@_normal",VCIconName];
    NSString *selImg = [NSString stringWithFormat:@"%@_selected",VCIconName];
    return [self addTabBarChildVCWithVCClass:VCClass VCTitle:VCTitle VCImageName:normalImg VCSelImageName:selImg];
    
}

-(UINavigationController *) addTabBarChildVCWithVCClass:(Class) VCClass VCTitle:(NSString *) VCTitle VCImageName:(NSString *) VCImageName VCSelImageName:(NSString *) VCSelImageName{
    
    UIViewController *VC = [[VCClass alloc] init];
    
    // 导航栏设置为有透明度的(默认就是半透明的), UIViewController的View就会被导航栏覆盖，若不想被覆盖：self.edgesForExtendedLayout = UIRectEdgeNone;
    // 如果导航栏是不透明的, 默认UIViewController的View就会往下移, 在导航栏下显示, 若不想往下移：self.extendedLayoutIncludesOpaqueBars = YES;
    
    VC.edgesForExtendedLayout = UIRectEdgeNone; // view 不被 nav 覆盖
//    VC.automaticallyAdjustsScrollViewInsets = NO;
//    VC.edgesForExtendedLayout = UIRectEdgeAll;
    
    UINavigationController *navVC;
    if ([VCTitle isEqualToString:@"书城"]) {
        navVC = [[KLTNavigationController alloc] initWithRootViewController:VC];
    }else{
        navVC = [[UINavigationController alloc] initWithRootViewController:VC];
    }
    
//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:VC];
    navVC.tabBarItem.title = VCTitle;
    navVC.tabBarItem.image = [UIImage imageNamed:VCImageName];
    navVC.tabBarItem.selectedImage = [[UIImage imageNamed:VCSelImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_ORANGE} forState:UIControlStateSelected];
//    UIEdgeInsets insets = UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0);
//    navVC.tabBarItem.imageInsets = insets;
    
//    KLTNavigationController *nav = [[KLTNavigationController alloc] initWithRootViewController:VC];
    
    
    return navVC;
}

#pragma mark - Delegate - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionFade];
    [animation setDuration:0.25];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:
                                  kCAMediaTimingFunctionEaseIn]];
    [self.view.window.layer addAnimation:animation forKey:@"fadeTransition"];
    
    return YES;
}

- (void)pushToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        
        [navigation pushViewController:viewController animated:animated];
    }
}

- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^ __nullable)(void))completion {
    if([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)self.selectedViewController;
        [navigation presentViewController:viewController animated:animated completion:completion];
    }
}


///**
// * 添加 WSTabBar 的子控制器
// */
//-(void) addTabBarOneChildViewControllerWithVC:(UIViewController *) VC VCTitle:(NSString *) VCTitle VCImageName:(NSString *) VCImageName VCSelImageName:(NSString *) VCSelImageName{
//
//    VC.title = VCTitle;
//    VC.tabBarItem.title = VCTitle;
//    VC.tabBarItem.image = [UIImage imageNamed:VCImageName];
//    VC.tabBarItem.selectedImage = [[UIImage imageNamed:VCSelImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [VC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB_ORANGE} forState:UIControlStateSelected];
//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:VC];
//    [self addChildViewController:navVC];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
