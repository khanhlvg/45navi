//
//  ArticlesCache
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticlesCache : NSObject

@property NSArray* articles;
@property NSInteger selectedIndex;
@property NSMutableArray* visitedIndexList;

+ (ArticlesCache*)sharedInstance;

@end
