#import "ViewController.h"
#import "Models.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self populateData];
}

- (void)populateData
{
    SectionItem *fruitSection = [[SectionItem alloc] init];
    [fruitSection setSectionName:@"Fruits"];
    
    [[fruitSection sectionContents] addObject:[[FoodItem alloc] initWithName:@"Apple" color:[UIColor redColor]]];
    [[fruitSection sectionContents] addObject:[[FoodItem alloc] initWithName:@"Banana" color:[UIColor yellowColor]]];
    [[fruitSection sectionContents] addObject:[[FoodItem alloc] initWithName:@"Grape" color:[UIColor purpleColor]]];
    
    SectionItem *veggieSection = [[SectionItem alloc] init];
    [veggieSection setSectionName:@"Vegetables"];
    
    [[veggieSection sectionContents] addObject:[[FoodItem alloc] initWithName:@"Carrot" color:[UIColor orangeColor]]];
    [[veggieSection sectionContents] addObject:[[FoodItem alloc] initWithName:@"Celery" color:[UIColor greenColor]]];
    
    SectionItem *sweetSection = [[SectionItem alloc] init];
    [sweetSection setSectionName:@"Sweets"];
    [sweetSection setSectionFooter:@"I love dessert!"];
    
    [[sweetSection sectionContents] addObject:[[FoodItem alloc] initWithName:@"Chocolate" color:nil]];

    [self setContents:[@[ fruitSection, veggieSection, sweetSection ] mutableCopy]];
}

- (FoodItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    SectionItem *sectionItem = [[self contents] objectAtIndex:[indexPath section]];
    
    return [[sectionItem sectionContents] objectAtIndex:[indexPath row]];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self contents] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    SectionItem *sectionItem = [[self contents] objectAtIndex:section];
    
    return [[sectionItem sectionContents] count];
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    SectionItem *sectionItem = [[self contents] objectAtIndex:section];

    return [sectionItem sectionName];
}

- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section
{
    SectionItem *sectionItem = [[self contents] objectAtIndex:section];
    
    return [sectionItem sectionFooter];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Plain";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    FoodItem *foodItem = [self itemAtIndexPath:indexPath];
    
    [[cell textLabel] setText:[foodItem name]];
    
    if ([foodItem color] == nil)
    {
        [[cell textLabel] setTextColor:[UIColor blackColor]];
    }
    else
    {
        [[cell textLabel] setTextColor:[foodItem color]];
    }
    
    return cell;
}

@end
