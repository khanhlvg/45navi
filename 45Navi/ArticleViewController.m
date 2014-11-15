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

- (void)viewWillAppear:(BOOL)animated
{
    NVLocationManager *locationManager = [NVLocationManager sharedInstance];
    NVWikipediaListFetcher *wikiFetcher = [[NVWikipediaListFetcher alloc] initWithLocation:locationManager.currentLocation];
    
    [wikiFetcher startFetchingWithCompletionHandler:^(NSArray *result) {
        
    }];
    
    NVVoiceTextService *voiceService = [NVVoiceTextService sharedInstance];
    [voiceService readText:@"実際のカヤックやカヌーに搭乗し、それを操作することで船の基本や知識を学ぶための施設。"
     "2008年シーズンまでは、遊泳プールとして毎年営業していた。現地案内板には「シーサイドプール」と表記はそのままだが、公式サイトは「体験教室プール」に変更されている。"];
}

-(void)gotoNavigation{
  [self performSegueWithIdentifier:@"ArticleToNavigationSegue" sender:self];
}

@end
