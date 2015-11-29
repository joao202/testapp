//
//  MapViewAnnotation.m
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import "MapViewAnnotation.h"

@implementation MapViewAnnotation 

- (id)initWithTitle:(NSString *)title coordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self) {
        _title = title;
        _coordinate = coordinate;
    }
    return self;
}

@end
