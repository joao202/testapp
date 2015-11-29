//
//  MapViewController.m
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import "MapViewController.h"
#import "MapViewAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = _itemTitle;
    
    CLLocationCoordinate2D coord;
    coord.longitude = _itemLongitude;
    coord.latitude = _itemLatitude;
    
    MapViewAnnotation *annotation = [[MapViewAnnotation alloc] initWithTitle:_itemCity coordinate:coord];
    [self.mapvView addAnnotation:annotation];
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coord, 20000, 2000);
    [_mapvView setRegion:viewRegion animated:YES];
    [_mapvView regionThatFits:viewRegion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
