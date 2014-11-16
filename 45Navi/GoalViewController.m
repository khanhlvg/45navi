//
//  GoalViewController.m
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "GoalViewController.h"

@interface GoalViewController ()
@property (weak, nonatomic) IBOutlet UIView *reviewDialog;
@property (weak, nonatomic) IBOutlet UIImageView *dialogBlurImageView;

@end

@implementation GoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

  UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
  UIVisualEffectView * visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
  visualEffectView.frame = _dialogBlurImageView.bounds;
  [_dialogBlurImageView addSubview:visualEffectView];
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
