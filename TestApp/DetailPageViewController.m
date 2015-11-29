//
//  DetailPageViewController.m
//  TestApp
//
//  Created by João on 25/11/15.
//
//

#import "DetailPageViewController.h"
#import "DetailContentViewController.h"
#import "Item.h"

@interface DetailPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) UIBarButtonItem *shareButton;

@end

@implementation DetailPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Set title
    self.title = @"Detail";
    
    // Init page controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    self.pageViewController.delegate = self;
    
    DetailContentViewController *startingViewController = [self viewControllerAtIndex:_startIndex];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = (CGRect) {
        .origin.x = 0,
        .origin.y = 0,
        .size.width = self.view.frame.size.width,
        .size.height = self.view.frame.size.height
    };
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    // Set share action
    self.shareButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(didTapShareButton:)];
    self.navigationItem.rightBarButtonItem = self.shareButton;
    
    _currentIndex = _startIndex;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DetailContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([_items count] == 0) || (index >= [_items count])) {
        return nil;
    }
    
    Item *item = (Item *)self.items[index];
    
    DetailContentViewController *detailContentlVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailContentViewController"];
    detailContentlVC.item = item;
    detailContentlVC.pageIndex = index;
    
    return detailContentlVC;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((DetailContentViewController *)viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((DetailContentViewController *)viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    
    if (index == [_items count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_items count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        DetailContentViewController *detailVC =[self.pageViewController.viewControllers lastObject];
        _currentIndex = detailVC.pageIndex;
    }
    
}

#pragma mark - Share

- (void)didTapShareButton:(id)sender {
    Item *item = _items[_currentIndex];
    NSArray* sharedObjects = @[item.title, item.url];
    UIActivityViewController * activityViewController=[[UIActivityViewController alloc]initWithActivityItems:sharedObjects applicationActivities:nil];
    
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
