//
//  MapViewController.h
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapvView;
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemCity;
@property (nonatomic, assign) double itemLongitude;
@property (nonatomic, assign) double itemLatitude;

@end
