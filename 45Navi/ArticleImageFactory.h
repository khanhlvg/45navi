//
//  ArticleImageFactory.h
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DraggableViewBackground.h"

@interface ArticleImageFactory : NSObject
+(UIView*)imageMake:(NSString*)title image:(UIImage*)img;
@end
