#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *contents;
@property (nonatomic, strong) NSMutableArray *headers;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableDictionary *items = [NSMutableDictionary dictionary];
    NSMutableArray *keys = [NSMutableArray array];
    
    NSString *garageKey = @"Garage";
    NSString *masterBathroomKey = @"Master Bathroom";
    NSString *diningRoomKey = @"Dining Room";
    NSString *guestBathroomKey = @"Master Bedroom";
    NSString *kitchenKey = @"Kitchen";
    NSString *denKey = @"Den";
    
    NSArray *garage = @[ @"Motor Oil", @"Light Bulbs", @"Trash Bags", @"Flashlight" ];
    NSArray *masterBathroom = @[ @"Soap", @"Shampoo", @"Toothpaste", @"Hair Spray", @"First Aid" ];
    NSArray *diningRoom = @[ ];
    NSArray *guestBathroom = @[ @"Hand Soap", @"Tissues", @"Toilet Paper" ];
    NSArray *kitchen = @[ @"Milk", @"Bread", @"Pizza", @"Juice", @"Cheese", @"Coffee" ];
    NSArray *den = @[ @"Pens", @"Pencils", @"Paper", @"Stamps" ];
    
    [items setObject:garage forKey:garageKey];
    [items setObject:masterBathroom forKey:masterBathroomKey];
    [items setObject:diningRoom forKey:diningRoomKey];
    [items setObject:guestBathroom forKey:guestBathroomKey];
    [items setObject:kitchen forKey:kitchenKey];
    [items setObject:den forKey:denKey];
    
    [keys addObject:garageKey];
    [keys addObject:masterBathroomKey];
    [keys addObject:diningRoomKey];
    [keys addObject:guestBathroomKey];
    [keys addObject:kitchenKey];
    [keys addObject:denKey];
    
    [self setContents:items];
    [self setHeaders:keys];
}

- (NSString *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[self headers] objectAtIndex:[indexPath section]];
    NSArray *groupArray = [[self contents] objectForKey:key];
    NSString *text = [groupArray objectAtIndex:[indexPath row]];
    
    return text;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self headers] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    NSString *header = [[self headers] objectAtIndex:section];
    NSString *key = [[self headers] objectAtIndex:section];
    NSArray *groupArray = [[self contents] objectForKey:key];

    return ([groupArray count] > 0) ? header : nil;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[self headers] objectAtIndex:section];
    NSArray *groupArray = [[self contents] objectForKey:key];
    
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

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *titles = [NSMutableArray array];
    
    for (NSString *header in [self headers])
    {
        NSString *title = @"";
        NSArray *words = [header componentsSeparatedByString:@" "];
        for (NSString *word in words)
        {
            NSString *firstLetter = [[word substringToIndex:1] uppercaseString];
            title = [title stringByAppendingString:firstLetter];
        }
        [titles addObject:title];
    }
    
    return titles;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self itemAtIndexPath:indexPath];
    
    NSLog(@"text: %@", text);
}

@end
