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
    [voiceService readText:@"日本初の格闘技専用アリーナと銘打ち、2000年にオープンした。プロレス団体の一つである、プロレスリング・ノアが事務所、道場、合宿所を置いている。"];
}

-(void)gotoNavigation{
  [self performSegueWithIdentifier:@"ArticleToNavigationSegue" sender:self];
}

@end
