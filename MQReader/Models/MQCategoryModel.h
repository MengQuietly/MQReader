//
//  MQCategoryModel.h
//  MQReader
//
//  Created by mengY on 2019/5/16.
//  Copyright © 2019 Meng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MQCategoryModel : NSObject

/// 名称
@property (nonatomic , copy) NSString *name;
@property (nonatomic , assign) NSInteger bookCount;
@property (nonatomic , assign) NSInteger monthlyCount;
@property (nonatomic , copy) NSString *icon;
@property (nonatomic , copy) NSArray *bookCover;

@end

NS_ASSUME_NONNULL_END
