//
//  ArticleImageFactory.m
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "ArticleImageFactory.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"

@implementation ArticleImageFactory

+(UIView*)imageMake:(NSString*)title image:(NSString*)imgUrl{

  UIView* tmp = [[UIView alloc]initWithFrame:(CGRect){0,0,CARD_WIDTH,CARD_HEIGHT}];
  UIImageView* imgView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,CARD_WIDTH,CARD_HEIGHT - 100}];
  NSURL *url = [NSURL URLWithString:imgUrl];
  [imgView setImageWithURL:url];
  [tmp addSubview:imgView];
  UILabel* titleLabel = [[UILabel alloc]initWithFrame:(CGRect){30,CARD_HEIGHT - 100,CARD_WIDTH-60,100}];
  titleLabel.numberOfLines=3;
  titleLabel.text = title;
  [tmp addSubview:titleLabel];
  
  return tmp;
}

@end
