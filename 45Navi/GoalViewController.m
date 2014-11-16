//
//  GoalViewController.m
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "GoalViewController.h"
#import "NVPlaceEntity.h"
#import <UIImageView+AFNetworking.h>
#import "NVEventDataFetcher.h"
#import "NVLocationManager.h"
#import "NVVoiceTextService.h"

#import "ArticlesCache.h"

@interface GoalViewController ()
@property (weak, nonatomic) IBOutlet UIView *reviewDialog;
@property (weak, nonatomic) IBOutlet UIImageView *dialogBlurImageView;
@property (weak, nonatomic) IBOutlet UILabel *explainationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goalPicture;

@property (nonatomic) NVPlaceEntity *entity;

@end

@implementation GoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
  UIVisualEffectView * visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
  visualEffectView.frame = _dialogBlurImageView.bounds;
  [_dialogBlurImageView addSubview:visualEffectView];
    
    // setup entity
    NSArray* articleCaches = [[ArticlesCache sharedInstance] articles];
    self.entity = [articleCaches objectAtIndex:[[ArticlesCache sharedInstance] selectedIndex]];
    [self setupWithEntity:self.entity];
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    NVLocationManager *locationManager = [NVLocationManager sharedInstance];
//    
//    NVEventDataFetcher *eventFetcher = [[NVEventDataFetcher alloc] initWithLocation:locationManager.currentLocation];
//    [eventFetcher startFetchingWithCompletionHandler:^(NSArray *result) {
//        [self setupWithEntity:[result lastObject]];
//    }];
//
//}

- (void)setupWithEntity:(NVPlaceEntity *)entity
{
    if (!entity) {
        return;
    }
    
    self.explainationLabel.text = entity.explanation;
    
    NSURL *url = [NSURL URLWithString:entity.imageURL];
    [self.goalPicture setImageWithURL:url];
    
    [[NVVoiceTextService sharedInstance] readText:entity.explanation];
}

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

- (IBAction)reviewOpen:(id)sender {
  _reviewDialog.hidden = NO;
}

- (IBAction)review1Star:(id)sender {
  _reviewDialog.hidden = YES;
}
- (IBAction)review2Stars:(id)sender {
  _reviewDialog.hidden = YES;
}
- (IBAction)review3Stars:(id)sender {
  _reviewDialog.hidden = YES;
}

@end
