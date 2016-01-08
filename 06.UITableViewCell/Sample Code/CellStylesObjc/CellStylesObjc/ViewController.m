#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch ([indexPath row])
    {
        case 1:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Value1"];
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        case 2:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"Value2"];
            [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
            break;
        case 3:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subtitle"];
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            break;
        case 4:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Subtitle2"];
            [[cell textLabel] setText:@"Hello"];
            [cell setAccessoryType:UITableViewCellAccessoryDetailButton];
            return cell;
            break;
        default:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Default"];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            break;
    }
    
    [[cell textLabel] setText:@"Hello"];
    [[cell detailTextLabel] setText:@"World"];
    [cell setAccessoryView:[[UISwitch alloc] init]];
    [[cell imageView] setImage:[UIImage imageNamed:@"image"]];
    
    return cell;
}

@end
