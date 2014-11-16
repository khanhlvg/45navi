//
//  NavigationViewController.m
//  45Navi
//
//  Created by yoshiki on 2014/11/16.
//  Copyright (c) 2014年 45Navi Team. All rights reserved.
//

#import "NavigationViewController.h"
#import <MapKit/MapKit.h>
#import "NVPlaceEntity.h"
#import "NVWikipediaListFetcher.h"
#import "NVLocationManager.h"

@interface NavigationViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation NavigationViewController

- (void)setupWithEntity:(NVPlaceEntity *)entity
{
//    NVLocationManager *locationManager = [NVLocationManager sharedInstance];
    
    [self.mapView addAnnotation:entity];
    
    if (entity.route) {
        [self.mapView addOverlay:entity.route.polyline level:MKOverlayLevelAboveRoads];
    }
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // ==== test code ====
    NVLocationManager *locationManager = [NVLocationManager sharedInstance];
    NVWikipediaListFetcher *wikiFetcher = [[NVWikipediaListFetcher alloc] initWithLocation:locationManager.currentLocation];
    
    [wikiFetcher startFetchingWithCompletionHandler:^(NSArray *result) {
        [self setupWithEntity:[result lastObject]];
    }];
    // ==== end test code ====
    
    self.mapView.showsUserLocation = YES;
    
    if (self.entity) {
        [self setupWithEntity:self.entity];
    }
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

@end
