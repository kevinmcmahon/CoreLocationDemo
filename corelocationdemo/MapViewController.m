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
    UILabel *_label;
}

@end

@implementation MapViewController

- (void)initialize {
    CLLocationCoordinate2D initialCoordinate;
    initialCoordinate.latitude = 41.881080;
    initialCoordinate.longitude = -87.701208;

    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(initialCoordinate, 400, 400) animated:YES];
    _mapView.centerCoordinate = initialCoordinate;
    
    // 1. Enable the 'blue dot' to show user location and enable map to follow it
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.purpose = @"Please let me track you! For demo purposes of course.";
    
    // 2. Create a label to display lat and long
    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 419, 280, 21)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = UITextAlignmentCenter;
    _label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
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
    // 4. Wire up the location manager delegate to the view controller
    _locationManager.delegate = self;
    
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
    [self.view addSubview:_label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Location Manager Callback Methods

// 5. Handle location updates
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    _label.text = [NSString stringWithFormat:@"%f, %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
}

@end
