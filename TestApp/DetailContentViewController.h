//
//  DetailContentViewController.h
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface DetailContentViewController : UIViewController

@property (nonatomic, strong) Item *item;
@property (nonatomic, assign) NSInteger pageIndex;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
