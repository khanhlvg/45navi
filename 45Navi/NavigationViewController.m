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
#import "ArticlesCache.h"

@interface NavigationViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *arrivedButton;
@property (nonatomic) BOOL isMyEntityDisplayed;

@end

@implementation NavigationViewController

- (void)setupWithEntity:(NVPlaceEntity *)entity
{
    NVLocationManager *locationManager = [NVLocationManager sharedInstance];
    NVPlaceEntity *currentLocEntity = [[NVPlaceEntity alloc] init];
    currentLocEntity.placeName = @"現在地";
    currentLocEntity.location = locationManager.currentLocation;
    
    MKCoordinateRegion regionToFit = [self.class regionForAnnotations:@[currentLocEntity, entity]];
    [self.mapView setRegion:regionToFit animated:YES];
    
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
//    NVLocationManager *locationManager = [NVLocationManager sharedInstance];
//    NVWikipediaListFetcher *wikiFetcher = [[NVWikipediaListFetcher alloc] initWithLocation:locationManager.currentLocation];
//    
//    [wikiFetcher startFetchingWithCompletionHandler:^(NSArray *result) {
//        [self setupWithEntity:[result lastObject]];
//    }];
    // ==== end test code ====
    
    NSArray* articleCaches = [[ArticlesCache sharedInstance] articles];
    self.entity = [articleCaches objectAtIndex:[[ArticlesCache sharedInstance] selectedIndex]];
    
    self.mapView.showsUserLocation = YES;
    
    if (self.entity) {
        [self setupWithEntity:self.entity];
        NSNumber *myEntityIndex = [NSNumber numberWithInteger:[[ArticlesCache sharedInstance] selectedIndex]];
        self.isMyEntityDisplayed = [[[ArticlesCache sharedInstance] visitedIndexList] containsObject:myEntityIndex];
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.arrivedButton.hidden = NO;
    });
}

- (IBAction)clickArrivedBtn:(id)sender {
    UIViewController *vc;
    
    if (self.isMyEntityDisplayed) {
        vc =
        [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ArticleViewController"];
        
    } else {
        vc =
        [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"GoalViewController"];
    }
    
    [self presentViewController:vc animated:YES completion:nil];
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

+ (MKCoordinateRegion) regionForAnnotations:(NSArray*) annotations
{
    double minLat=90.0f, maxLat=-90.0f;
    double minLon=180.0f, maxLon=-180.0f;
    
    double supLat = 0.005f;
    double supLon = 0.005f;
    
    for (id<MKAnnotation> mka in annotations) {
        if ( mka.coordinate.latitude  < minLat ) minLat = mka.coordinate.latitude;
        if ( mka.coordinate.latitude  > maxLat ) maxLat = mka.coordinate.latitude;
        if ( mka.coordinate.longitude < minLon ) minLon = mka.coordinate.longitude;
        if ( mka.coordinate.longitude > maxLon ) maxLon = mka.coordinate.longitude;
    }
    
    minLat-=supLat;
    maxLat+=supLat;
    minLon-=supLon;
    maxLon+=supLon;
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake((minLat+maxLat)/2.0, (minLon+maxLon)/2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(maxLat-minLat, maxLon-minLon);
    MKCoordinateRegion region = MKCoordinateRegionMake (center, span);
    
    return region;
}


@end
