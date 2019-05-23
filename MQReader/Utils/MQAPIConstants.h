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
// 点击搜索 http://api.zhuishushenqi.com/book/hot-word?isfree=1&freeappid=1234491385
// 男  热搜 http://api.zhuishushenqi.com/book/hot-word?isfree=1&freeappid=1234491385
// 男 好评榜 http://api.zhuishushenqi.com/ranking/5a6844aafc84c2b8efaa6b6e?isfree=1&freeappid=1234491385

// 男 潜力榜 周榜 http://api.zhuishushenqi.com/ranking/54d42e72d9de23382e6877fb?isfree=1&freeappid=1234491385
// 男 潜力榜 月榜 http://api.zhuishushenqi.com/ranking/564eee3ea82e3ada6f14b195?isfree=1&freeappid=1234491385
// 男 潜力榜 总榜 http://api.zhuishushenqi.com/ranking/564eeeabed24953671f2a577?isfree=1&freeappid=1234491385

//http://api.zhuishushenqi.com/ranking/54d42d92321052167dfb75e3?isfree=1&freeappid=1234491385
// 找书-排行榜-男/女-类型
#define MQFindRankWithType @"ranking/54d42d92321052167dfb75e3"
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
