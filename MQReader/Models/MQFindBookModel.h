//
//  MQFindBookModel.h
//  MQReader
//
//  Created by mengJing on 2018/5/8.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQFindBookModel : NSObject

/*
"_id" = 5a68296bfc84c2b8ef9efdb0;
collapse = 0;
cover = "/ranking-cover/142319144267827";
shortTitle = "\U70ed\U641c\U699c";
title = "\U70ed\U9500\U699c";
*/
//@property (nonatomic , strong) NSNumber *_id;
/// ID
@property (nonatomic , copy) NSString *_id;
/// 名称
@property (nonatomic , assign) NSInteger collapse;
/// 名称
@property (nonatomic , copy) NSString *cover;
/// 日期
@property (nonatomic , copy) NSString *shortTitle;
/// 日期
@property (nonatomic , copy) NSString *title;

/// 日期
@property (nonatomic , copy) NSString *monthRank;
/// 日期
@property (nonatomic , copy) NSString *totalRank;

//这个来定位右边数据源滚动的位置
@property(assign,nonatomic) float offsetScorller;

@end
