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
    
    NSString *fruitKey = @"Fruits";
    NSString *vegetableKey = @"Vegetable";
    NSString *sweetKey = @"Sweets";
    
    NSArray *fruits = @[ @"Apple", @"Banana", @"Grape", @"Melon" ];
    NSArray *vegetables = @[ @"Carrot", @"Celery", @"Asparagus" ];
    NSArray *sweets = @[ @"Chocolate", @"Pie" ];
    
    [items setObject:fruits forKey:fruitKey];
    [items setObject:vegetables forKey:vegetableKey];
    [items setObject:sweets forKey:sweetKey];
    
    [keys addObject:fruitKey];
    [keys addObject:vegetableKey];
    [keys addObject:sweetKey];

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
    return [[self headers] objectAtIndex:section];
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

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self itemAtIndexPath:indexPath];
    
    NSLog(@"text: %@", text);
}

@end
