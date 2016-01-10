#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"PlainCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if ([indexPath row] == 0)
    {
        [[cell textLabel] setText:@"Red"];
    }
    else if ([indexPath row] == 1)
    {
        [[cell textLabel] setText:@"Orange"];
    }
    else if ([indexPath row] == 2)
    {
        [[cell textLabel] setText:@"Yellow"];
    }
    else if ([indexPath row] == 3)
    {
        [[cell textLabel] setText:@"Green"];
    }
    else if ([indexPath row] == 4)
    {
        [[cell textLabel] setText:@"Blue"];
    }
    else if ([indexPath row] == 5)
    {
        [[cell textLabel] setText:@"Magenta"];
    }

    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([indexPath row] == 0)
    {
        NSLog(@"Red");
    }
    else if ([indexPath row] == 1)
    {
        NSLog(@"Orange");
    }
    else if ([indexPath row] == 2)
    {
        NSLog(@"Yellow");
    }
    else if ([indexPath row] == 3)
    {
        NSLog(@"Green");
    }
    else if ([indexPath row] == 4)
    {
        NSLog(@"Blue");
    }
    else if ([indexPath row] == 5)
    {
        NSLog(@"Magenta");
    }
}

@end
