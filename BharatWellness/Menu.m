//
//  Menu.m
//  BharatWellness
//
//  Created by Bablu Joshi on 01/03/15.
//  Copyright (c) 2015 BabluJoshi. All rights reserved.
//

#import "Menu.h"

@interface Menu ()
@property (nonatomic, strong) UINavigationController *transitionsNavigationController;
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation Menu

- (void)viewDidLoad {
    [super viewDidLoad];
    self.transitionsNavigationController = (UINavigationController *)self.slidingViewController.topViewController;
    
    self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
}
#pragma mark - Properties

- (NSArray *)menuItems {
    if (_menuItems) return _menuItems;
    
    _menuItems = @[@"Home", @"Dairy",@"My Diet Plan",@"Refer a Friend",@"Reminder Settings",@"Logout"];
    
    return _menuItems;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.menuItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *menuItem = self.menuItems[indexPath.row];
    
    cell.textLabel.text = menuItem;
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.textLabel.textColor = [UIColor whiteColor];

    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.slidingViewController.topViewController = self.transitionsNavigationController;
    [self.slidingViewController resetTopViewAnimated:YES];


}

@end
