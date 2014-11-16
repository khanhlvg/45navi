//
//  ArticleViewController.m
//  45Navi
//
//  Created by yoshiki on 2014/11/15.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "ArticleViewController.h"
#import "DraggableViewBackground.h"
#import "NVWikipediaListFetcher.h"
#import "NVLocationManager.h"
#import "NVVoiceTextService.h"
#import "NVEventDataFetcher.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.frame];
  draggableBackground.delegate = self;
  [self.view addSubview:draggableBackground];
}

-(void)gotoNavigation{
  [self performSegueWithIdentifier:@"ArticleToNavigationSegue" sender:self];
}

@end
