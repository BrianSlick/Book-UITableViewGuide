#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) NSMutableArray *contents;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setContents:[@[ @"Red", @"Orange", @"Yellow", @"Green", @"Blue", @"Magenta"] mutableCopy]];
    
    [[self tableView] setAllowsMultipleSelectionDuringEditing:YES];
    
    [self updateDeleteButtonStatus];
}

- (IBAction)editButtonTapped:(UIButton *)sender
{
    UITableView *tableView = [self tableView];
    
    [tableView setEditing:![tableView isEditing] animated:YES];
    
    [sender setTitle:([tableView isEditing]) ? @"Done" : @"Edit" forState:UIControlStateNormal];
    
    [self updateDeleteButtonStatus];
}

- (IBAction)reloadButtonTapped:(UIButton *)sender
{
    [[self tableView] reloadData];
    
    [self updateDeleteButtonStatus];
}

- (IBAction)deleteButtonTapped:(UIButton *)sender
{
    NSArray *selection = [[self tableView] indexPathsForSelectedRows];
    
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    
    for (NSIndexPath *indexPath in selection)
    {
        [indexSet addIndex:[indexPath row]];
    }
    
    if ([selection count] > 0)
    {
        [[self contents] removeObjectsAtIndexes:indexSet];

        [[self tableView] deleteRowsAtIndexPaths:selection withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self updateDeleteButtonStatus];
    }
}

- (void)updateDeleteButtonStatus
{
    __weak ViewController *weakSelf = self;
    
    void (^setButtonTitle)(NSString *title, BOOL isEnabled) = ^(NSString *title, BOOL isEnabled)
    {
        [[weakSelf deleteButton] setTitle:title forState:UIControlStateNormal];
        [[weakSelf deleteButton] setEnabled:isEnabled];
    };

    NSString *rootButtonTitle = @"Delete";
    
    if (![[self tableView] isEditing])
    {
        setButtonTitle(rootButtonTitle, NO);
    }
    else
    {
        NSArray *selection = [[self tableView] indexPathsForSelectedRows];
        
        if ([selection count] == 0)
        {
            setButtonTitle(rootButtonTitle, NO);
        }
        else
        {
            NSString *buttonTitle = [rootButtonTitle stringByAppendingFormat:@" (%ld)", (long)[selection count]];
            setButtonTitle(buttonTitle, YES);
        }
    }
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[self contents] count];
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
    
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:rowValue];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateDeleteButtonStatus];
}

- (void)tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateDeleteButtonStatus];
}

@end