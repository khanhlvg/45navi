//
//  BootViewController.m
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "BootViewController.h"
#import "ArticlesCache.h"
#import "NVWikipediaListFetcher.h"
#import "NVLocationManager.h"
#import "NVVoiceTextService.h"
#import "NVEventDataFetcher.h"

@interface BootViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *startSpinner;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;

@end

@implementation BootViewController
- (IBAction)startBtnPushed:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [_startSpinner startAnimating];
  NVLocationManager *locationManager = [NVLocationManager sharedInstance];
  NVWikipediaListFetcher *wikiFetcher = [[NVWikipediaListFetcher alloc] initWithLocation:locationManager.currentLocation];
  
  NVEventDataFetcher *eventFetcher = [[NVEventDataFetcher alloc] initWithLocation:locationManager.currentLocation];
  [eventFetcher startFetchingWithCompletionHandler:^(NSArray *result) {
    [wikiFetcher startFetchingWithCompletionHandler:^(NSArray *result2) {
      [ArticlesCache sharedInstance].articles = [result2 arrayByAddingObjectsFromArray:result];
      [_startSpinner stopAnimating];
      _startSpinner.hidden = YES;
      _startBtn.imageView.image =[UIImage imageNamed:@"btn1.png"];
      
    }];
  }];
  
  NVVoiceTextService *voiceService = [NVVoiceTextService sharedInstance];
  [voiceService readText:@"日本初の格闘技専用アリーナと銘打ち、2000年にオープンした。プロレス団体の一つである、プロレスリング・ノアが事務所、道場、合宿所を置いている。"];}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
