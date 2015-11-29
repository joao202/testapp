//
//  MapViewAnnotation.h
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapViewAnnotation : NSObject <MKAnnotation>

@property (nonatomic,copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate;

@end
