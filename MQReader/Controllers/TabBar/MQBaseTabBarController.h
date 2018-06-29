//
//  MQBaseTabBarController.h
//  MQReader
//
//  Created by Meng on 2018/4/26.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MQBaseTabBarController : UITabBarController

- (void) setupTabBarItems;
- (void) pushToViewController:(UIViewController *) viewController animated:(BOOL) animated;
- (void)presentToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(void (^)(void))completion;

@end
