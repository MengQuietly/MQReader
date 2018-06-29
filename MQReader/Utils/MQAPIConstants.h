//
//  MQAPIConstants.h
//  MQReader
//
//  Created by Meng on 2018/5/7.
//  Copyright © 2018年 Meng. All rights reserved.
//

#ifndef MQAPIConstants_h
#define MQAPIConstants_h


// 服务器地址
#define MQServerAddress  @"http://api.zhuishushenqi.com/"



// 找书-排行榜
#define MQFindRank @"ranking/gender"
// 周榜/月榜/总榜
#define MQFindRanking @"ranking/%@"

// 书籍详细内容展示
#define MQBooksWithInfo @"book/%@"

// 书籍详细内容展示-热门书评
#define MQBooksWithHotReview @"post/review/best-by-book"

// 书籍详细内容展示-可能喜欢
#define MQBooksWithLike @"book/%@/recommend"

// 书籍详细内容展示-推荐书单
#define MQBookWithRecommendList @"book-list/%@/recommend"

// 全部章节内容阅读展示
#define MQBookWithAll @"mix-toc/%@"

// 换源
#define MQBookToc @"toc"

// 分类展示
#define MQCategoryShow @"cats/lv2/statistics"
// 分类展示-热门/新书/好评/完结
#define MQCategories @"book/by-categories"
// 分类展示-小分类（所有）
#define MQCategoriesWithCast @"cast/lv2"

// 大家都在搜
#define MQBookWithHotWord @"book/hot-word"
// 搜索-item 点击展示/输入字符后点击搜索展示
#define MQBookWithFuzzySearch @"book/fuzzy-search"
// 搜索-输入字符搜索
#define MQBookWithAutoComplete @"book/auto-complete"
// 掌上最热榜 top100
#define MQRankTop @"ranking/%@"







#endif /* MQAPIConstants_h */
