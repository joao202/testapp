//
//  SlideshowViewController.h
//  TestApp
//
//  Created by João on 28/11/15.
//
//

#import <UIKit/UIKit.h>

@interface SlideshowViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@property (nonatomic, strong) NSArray *images;

@end
