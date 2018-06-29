//
//  UIConstant.h
//  MQReader
//
//  Created by Meng on 2018/4/26.
//  Copyright © 2018年 Meng. All rights reserved.
//

#ifndef UIConstant_h
#define UIConstant_h

// Hint
#define BAD_NETWORK @"网络连接失败"
#define SERVER_ERROR @"服务器连接失败"

// HUD
#define HUD_DELAY 1.5

// Main Screen
#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define USE_HEIGHT (SCREEN_HEIGHT - 64)

#define ORIGINAL_MAX_WIDTH 640.0f

// RGB Color
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define RGBRandom RGBA(arc4random_uniform(256.0f), arc4random_uniform(256.0f), arc4random_uniform(256.0f), arc4random_uniform(256.0f))
#define RGB_ORANGE RGB(215, 147, 17)

#define RGBSelect RGB(255, 185, 15)
#define RGBNormal RGB(105, 105, 105)
#define RGBGray RGB(220, 220, 220)

// 字体
#pragma mark - font
#define FontWithNameSize(name, size)    [UIFont fontWithName:name size:size]
#define FontWithSize(size)              [UIFont systemFontOfSize:size]
#define ScoreFontWithSize(fontSize)     [UIFont fontWithName:@"Bradley Hand" size:fontSize]
#define BoldFontWithSize(size)          [UIFont boldSystemFontOfSize:size]



#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#endif /* UIConstant_h */
