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
    
    [wikiFetcher startFetchingWithCompletionHandler:^(NVPlaceEntity *result) {
        
    }];
}

-(void)gotoNavigation{
  [self performSegueWithIdentifier:@"ArticleToNavigationSegue" sender:self];
}

@end
