//
//  MapViewController.m
//  corelocationdemo
//
//  Created by Kevin McMahon on 8/12/12.
//  Copyright (c) 2012 Kevin McMahon. All rights reserved.
//

#import "MapViewController.h"

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
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];

    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.purpose = @"Please let me track you! For demo purposes of course.";

    _label = [[UILabel alloc] initWithFrame:CGRectMake(20, 419, 280, 21)];
    _label.backgroundColor = [UIColor clearColor];
    _label.textColor = [UIColor whiteColor];
    _label.textAlignment = UITextAlignmentCenter;
    _label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initializeLocationManager {
    _locationManager.delegate = self;

    if ([CLLocationManager locationServicesEnabled]) {
        LogDebug(@"Location services enabled.");

        if (CLLocationManager.regionMonitoringAvailable
                && CLLocationManager.regionMonitoringEnabled) {
            LogDebug(@"Region monitoring available and enabled.");

            [self registerRegionsForMonitoring];
        }

        [_locationManager startUpdatingLocation];
    }
}

- (void)registerRegionsForMonitoring {

    LogDebug(@"%d regions registered already",[_locationManager.monitoredRegions count]);

    for(CLRegion *region in _locationManager.monitoredRegions) {
        LogDebug(@"Registered Region : %@", region.identifier);
    }

    CLLocationCoordinate2D cloudGate = CLLocationCoordinate2DMake(41.882669, -87.623297);

    CLRegion *cloudGateRegion = [[CLRegion alloc] initCircularRegionWithCenter:cloudGate
                                                                        radius:100.0
                                                                    identifier:CLOUD_GATE_IDENTIFIER];
    [_locationManager startMonitoringForRegion:cloudGateRegion];
    
    LogDebug(@"Monitoring %d regions",[_locationManager.monitoredRegions count]);    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND_IMAGE]]];

    [self initializeLocationManager];
    [self.view addSubview:_mapView];
    [self.view addSubview:_label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Location Manager Callback Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    _label.text = [NSString stringWithFormat:@"%f, %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    LogDebug(@"Entered Region - %@", region.identifier);
    [self showAlert:@"Entering Region" forRegion:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    LogDebug(@"Exited Region - %@", region.identifier);
    [self showAlert:@"Exiting Region" forRegion:region.identifier];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    LogDebug(@"%@", error);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    LogDebug(@"%@ failed with:\n%@", region.identifier, error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    LogDebug(@"Starting to monitor : %@", region.identifier);
}

- (void) showAlert:(NSString *)alertText forRegion:(NSString *)regionIdentifier {
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:alertText
                                                      message:regionIdentifier
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
}

@end
