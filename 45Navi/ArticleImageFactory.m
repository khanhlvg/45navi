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

+(UIImage*)imageMake:(NSString*)title image:(NSString*)imgUrl{

  UIView* tmp = [[UIView alloc]initWithFrame:(CGRect){0,0,CARD_WIDTH,CARD_HEIGHT}];
  UIImageView* imgView = [[UIImageView alloc]initWithFrame:(CGRect){0,0,CARD_WIDTH,CARD_HEIGHT - 100}];
  NSURL *url = [NSURL URLWithString:imgUrl];
  imgView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];//todo sync->async
  [tmp addSubview:imgView];
  UILabel* titleLabel = [[UILabel alloc]initWithFrame:(CGRect){30,CARD_HEIGHT - 100,CARD_WIDTH-60,100}];
  titleLabel.numberOfLines=3;
  titleLabel.text = title;
  [tmp addSubview:titleLabel];
  
  UIImage *capture;
  UIGraphicsBeginImageContext(tmp.bounds.size);
  [tmp.layer renderInContext:UIGraphicsGetCurrentContext()];
  capture = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return capture;
  
}

@end
