//
//  DetailContentViewController.m
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import <Social/Social.h>
#import "DetailContentViewController.h"
#import "MapViewController.h"
#import "SlideshowViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailContentViewController ()

@end

@implementation DetailContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set title
    self.titleLabel.text = self.item.title;
    
    // Set descritption
    self.descriptionLabel.text = self.item.desc;
    self.descriptionLabel.numberOfLines = 0;

    // Set image
    [self.imageView setImageWithURL:[NSURL URLWithString:[self.item.photos lastObject]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MapSegue"]) {
        MapViewController *mapVC = (MapViewController *)[segue destinationViewController];
        double longitude = [_item.mapLon doubleValue];
        double latitude = [_item.mapLat doubleValue];
        mapVC.itemLongitude = longitude;
        mapVC.itemLatitude = latitude;
        mapVC.itemCity = _item.cityLabel;
        mapVC.itemTitle = _item.title;
    }
    else if ([segue.identifier isEqualToString:@"SlideshowSegue"]) {
        SlideshowViewController *slideshowVC = (SlideshowViewController *)[segue destinationViewController];
        slideshowVC.images = _item.photos;
    }
}

@end
