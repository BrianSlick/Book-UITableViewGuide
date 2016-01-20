//
//  ViewController.m
//  SectionsStructureObjc
//
//  Created by Brian Slick on 1/19/16.
//  Copyright © 2016 Brian Slick. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSArray *headers;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *fruits = @[ @"Apple", @"Banana", @"Grape", @"Melon" ];
    NSArray *vegetables = @[ @"Carrot", @"Celery", @"Asparagus" ];
    NSArray *sweets = @[ @"Chocolate", @"Pie" ];
    
    [self setContents:@[ fruits, vegetables, sweets ]];
    
    [self setHeaders:@[ @"Fruits", @"Vegetables", @"Sweets" ]];
}

- (NSString *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *groupArray = [[self contents] objectAtIndex:[indexPath section]];
    NSString *text = [groupArray objectAtIndex:[indexPath row]];
    
    return text;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self contents] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return [[self headers] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSArray *groupArray = [[self contents] objectAtIndex:section];
    
    return [groupArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Plain"];
    
    NSString *text = [self itemAtIndexPath:indexPath];
    
    [[cell textLabel] setText:text];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self itemAtIndexPath:indexPath];
    
    NSLog(@"text: %@", text);
}

@end
