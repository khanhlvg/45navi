//
//  ArticleViewController.m
//  45Navi
//
//  Created by yoshiki on 2014/11/15.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "ArticleViewController.h"
#import "DraggableViewBackground.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
  [self.view addSubview:draggableBackground];
}

@end
