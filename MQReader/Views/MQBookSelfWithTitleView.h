//
//  MQBookSelfWithTitleView.h
//  MQReader
//
//  Created by Meng on 2018/4/27.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MQBookSelfWithTitleViewDelegate <NSObject>

@optional
-(void) didTouchBtnWithIndex:(NSInteger) index;

@end

@interface MQBookSelfWithTitleView : UIView

@property (nonatomic, weak) id<MQBookSelfWithTitleViewDelegate> bookSelfWithTitleViewDelegate;


@end
