//
//  ANRightTableViewController.m
//  ANWeather
//
//  Created by a on 15/12/29.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
// 
#import "ANRightTableViewController.h"
#import "ViewController.h"
#import "ANRightTableViewCell.h"

#import "ANSearchBar.h"


@interface ANRightTableViewController ()
@property (strong, nonatomic)ANSearchBar *searchBar;

@end

@implementation ANRightTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    [self setupTableView];
    
    // 初始化searchBar
    [self setupSearchBar];
}

- (void)setupSearchBar
{
    self.searchBar = [ANSearchBar searchBar];

    self.searchBar.frame = CGRectMake(ANScreenWidth*0.5, -30, 100, 30);
    [self.tableView addSubview:self.searchBar];
}

- (void)setupTableView
{
    self.tableView.frame = CGRectMake(0, (ANScreenHeight - 54 * 5) /2.0f, ANScreenWidth, 54*5);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    
    self.tableView.contentInset = UIEdgeInsetsMake(ANScreenHeight*0.5, 0, 0, 0);
    self.tableView.contentSize = CGSizeMake(ANScreenWidth*0.1, ANScreenHeight);
    self.tableView.backgroundColor = ANRandomColor;
    self.tableView.backgroundView = nil;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    ANRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ANRightTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
#warning cell向右靠
        // 屏幕适配
        CGFloat indentationLevel = ANScreenWidth / 26;
        cell.indentationLevel = indentationLevel;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
        
    }
    NSArray *titles = @[@"Home", @"Settings", @"神秘选项", @"意见反馈", @"评分", @"About"];
    NSArray *images = @[@"IconHome", @"IconProfile", @"IconSettings", @"IconProfile", @"IconSettings", @"IconSettings"];
    
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
#warning 待改
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 4:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
        case 5:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]] animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
            
            
            
        default:
            break;
    }
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
