//
//  ViewController.m
//  TestApp
//
//  Created by João on 23/11/15.
//
//

#import "ViewController.h"
#import "RequestManager.h"
#import "Item.h"
#import "DetailPageViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIRefreshControl *refresh;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"List";
    
    // Pull-to-refresh
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.tintColor = [UIColor grayColor];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    [self.refresh addTarget:self action:@selector(didPullToRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refresh];
    
    [self loadDataAndForceUpdate:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:self.tableView.indexPathForSelectedRow animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadDataAndForceUpdate:(BOOL)forceUpdate {
    [RequestManager fetchDataWithSuccessBlock:^(NSArray * items) {
        self.items = items;
        [self.refresh endRefreshing];
        [_tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error on loading data");
        [self.refresh endRefreshing];
        [self displayAlert];
    } forceUpdate:forceUpdate];
}

- (void)didPullToRefresh
{
    [self loadDataAndForceUpdate:YES];
}

- (void)displayAlert
{
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error"
                                                                        message:@"Could not fetch data"
                                                                 preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:nil];
    
    [controller addAction: alertAction];
    
    [self presentViewController: controller animated: YES completion: nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailSegue"]) {
        DetailPageViewController *detailPageVC = (DetailPageViewController *)[segue destinationViewController];
        detailPageVC.items = _items;
        detailPageVC.startIndex = _tableView.indexPathForSelectedRow.row;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    Item *item = [_items objectAtIndex:indexPath.row];
    NSString *str = item.title;
    cell.textLabel.text = str;
    cell.detailTextLabel.text = item.created;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 88.0 : 56.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"DetailSegue" sender:self];
}

@end
