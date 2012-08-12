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
}

@end

@implementation MapViewController

- (void)initialize {
    // Coordinate we'll use to start our map view from.
    CLLocationCoordinate2D initialCoordinate;
    initialCoordinate.latitude = 41.881080;
    initialCoordinate.longitude = -87.701208;

    // 1. Initialize the map view with a frame that will take up the screen.
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    
    // 2. Set the region of the map to display using our initial coordinate
    [_mapView setRegion:MKCoordinateRegionMakeWithDistance(initialCoordinate, 400, 400) animated:YES];
    // 3. Center the map on the initial coordinate
    [_mapView setCenterCoordinate:initialCoordinate];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:BACKGROUND_IMAGE]]];
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
