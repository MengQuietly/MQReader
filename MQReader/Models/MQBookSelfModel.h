//
//  MQBookSelfModel.h
//  MQReader
//
//  Created by Meng on 2018/4/28.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQBookSelfModel : NSObject

/// ID
@property (nonatomic , strong) NSNumber *BookId;
/// 名称
@property (nonatomic , copy) NSString *BookName;
/// 名称
@property (nonatomic , copy) NSString *userName;
/// 日期
@property (nonatomic , copy) NSString *created_at;


@end
