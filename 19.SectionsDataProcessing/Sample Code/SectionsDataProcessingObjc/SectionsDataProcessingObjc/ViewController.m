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
    
    [self populateData];
}

- (void)populateData
{
    NSMutableDictionary *sections = [NSMutableDictionary dictionary];
    [self setContents:sections];
    
    NSArray *sourceData = @[ @"Chocolate", @"Pie", @"Carrot", @"Celery", @"Asparagus", @"Apple", @"Banana", @"Grape", @"Melon", @"Strawberry", @"Rutabaga", @"Papaya" ];
    [self setHeaders:[@[ @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z" ] mutableCopy]];
    
    for (NSString *key in [self headers])
    {
        [sections setObject:[NSMutableArray array] forKey:key];
    }
    
    for (NSString *item in sourceData)
    {
        NSString *firstLetter = [[item substringToIndex:1] uppercaseString];
        
        NSMutableArray *section = [sections objectForKey:firstLetter];
        [section addObject:item];
    }
    
    for (NSMutableArray *section in [sections allValues])
    {
        [section sortUsingSelector:@selector(localizedStandardCompare:)];
    }
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
