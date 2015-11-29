//
//  DetailPageViewController.h
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import <UIKit/UIKit.h>

@interface DetailPageViewController : UIViewController

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, assign) NSInteger startIndex;
@property (nonatomic, assign) NSInteger currentIndex;

@end
