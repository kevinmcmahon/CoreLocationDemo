//
//  MapViewController.m
//  corelocationdemo
//
//  Created by Kevin McMahon on 8/12/12.
//  Copyright (c) 2012 Kevin McMahon. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () {
    MKMapView *_mapView;
    CLLocationManager *_locationManager;
}

@end

@implementation MapViewController

- (void)initialize {
    CLLocationCoordinate2D initialCoordinate;
    initialCoordinate.latitude = 41.881080;
    initialCoordinate.longitude = -87.701208;

    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(initialCoordinate, 400, 400) animated:YES];
    [_mapView setCenterCoordinate:initialCoordinate];
    
    // 1. Alloc and init a location manager
    _locationManager = [[CLLocationManager alloc] init];

    // 2. Set your desired accurracy
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    // 3. Provide the user with an explanation of why you need to track location
    _locationManager.purpose = @"Please let me track you! For demo purposes of course.";
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void) initializeLocationManager {
    
    // 4. Check to ensure that location services are enabled.
    if ([CLLocationManager locationServicesEnabled]) {
        LogDebug(@"Location services enabled.");
        [_locationManager startUpdatingLocation];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND_IMAGE]]];
    
    [self initializeLocationManager];
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
