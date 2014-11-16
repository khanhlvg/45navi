//
//  ArticlesCache
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "ArticlesCache.h"

@implementation ArticlesCache

+ (ArticlesCache*)sharedInstance{
  static ArticlesCache* sharedInstance;
  static dispatch_once_t once;
  dispatch_once( &once, ^{
    sharedInstance = [[self alloc] init];
    sharedInstance.articles = nil;
  });
  return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.visitedIndexList = [NSMutableArray new];
    }
    
    return self;
}



@end
