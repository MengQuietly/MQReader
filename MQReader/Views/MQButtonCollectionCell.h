//
//  MQButtonCollectionCell.h
//  MQReader
//
//  Created by mengJing on 2018/5/8.
//  Copyright © 2018年 Meng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MQFindBookModel;

@interface MQButtonCollectionCell : UICollectionViewCell

@property (nonatomic, strong) MQFindBookModel * findBookModel;

@property (nonatomic, assign) BOOL hasBeenSelected;

@end
