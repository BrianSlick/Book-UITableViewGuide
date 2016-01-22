< [Custom Model Objects](../18.SectionsCustomModelObjects/SectionsCustomModelObjects.md) | >

# Multiple Sections: Data Processing

This topic is not inherently related to table views in any way, but does frequently arise in this context. You have data that is in one particular form (and you may not have any control over that) and would like to rearrange it for table view usage. The source data could be anything. Plain text files like CSV, plist, or XML. Data retrieved from a server like an RSS feed or something provided via an API. It is very common for data like this to be in a "flat" format, by which I mean it is not grouped. It is just one long list of records, and it is up to you to come up with the means to put those records into different groups or buckets.

There is no universal solution here, really. The work you need to do will depend highly on 1) what the source data is, and 2) what you want your table view to do with it. What I offer here is merely a simplified example to help get your wheels turning about how to solve your own problems.

We're going to continue with our food example, but we're going to take inspiration from the Contacts app and group the items alphabetically instead of by kind. We will display headers that show letters "A", "B", etc as appropriate. To simulate data we don't control, we'll start with just a list of foods in an array (by hand, sorry; processing a file is out of scope here).

## Setup

Create a new iOS project, using the Single View Application template. Name it anything you want, like SectionsDataProcessing. Choose your preferred language, device doesn't really matter but let's go with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter. Using your preferred technique, configure the provided view controller for table view use.

For convenience, we will use the array and dictionary structure highlighted in the [Another Basic Data Structure](../17.SectionsAnotherBasicDataStructure/SectionsAnotherBasicDataStructure.md) chapter. We'll start roughly where that chapter ends, so make your view controller look like this:

```objc
// Objective-C

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
```
```swift
// Swift

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var contents = [String: [String]]()
    var headers = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        populateData()
    }
    
    func populateData()
    {
        
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> String
    {
        let key = headers[indexPath.section]
        if let groupArray = contents[key]
        {
            let text = groupArray[indexPath.row]
            
            return text
        }
        
        return ""
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return headers.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return headers[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let key = headers[section]
        if let groupArray = contents[key]
        {
            return groupArray.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Plain")
        
        let text = itemAtIndexPath(indexPath)
        
        cell.textLabel?.text = text
        
        return cell;
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let text = itemAtIndexPath(indexPath)
        
        print(text)
    }
}
```
## Design

Let's begin with our source data. We're going to pretend this came from somewhere else, such as a text file or a web service.

```objc
// Objective-C

- (void)populateData
{
    NSArray *sourceData = @[ @"Chocolate", @"Pie", @"Carrot", @"Celery", @"Asparagus", @"Apple", @"Banana", @"Grape", @"Melon" ];
}
```
```swift
// Swift

func populateData()
{
    let sourceData = [ "Chocolate", "Pie", "Carrot", "Celery", "Asparagus", "Apple", "Banana", "Grape", "Melon"]
}
```
We want to place these items into buckets according to their first letter. So apple and asparagus would go into the "A" bucket, banana into the "B" bucket, and so on.

We can change our minds on this later, but for now let's plan on showing a header for all letters, even if no food items match. That's a known data set, so we can just hard-code it into our headers array. And then we want to make sure there is an array in the dictionary for each of those letters/keys.

```objc
// Objective-C

- (void)populateData
{
    NSMutableDictionary *sections = [NSMutableDictionary dictionary];
    [self setContents:sections];
    
    NSArray *sourceData = @[ @"Chocolate", @"Pie", @"Carrot", @"Celery", @"Asparagus", @"Apple", @"Banana", @"Grape", @"Melon" ];
    [self setHeaders:[@[ @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z" ] mutableCopy]];
    
    for (NSString *key in [self headers])
    {
        [sections setObject:[NSMutableArray array] forKey:key];
    }
}
```
```swift
// Swift

func populateData()
{
    let sourceData = [ "Chocolate", "Pie", "Carrot", "Celery", "Asparagus", "Apple", "Banana", "Grape", "Melon"]
    headers = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
    
    for key in headers
    {
        contents[key] = [String]()
    }
}
```
You can run the app now if you want, but all that you will see are the headers. We need to process our data.

## The Hard Part

In short, we need to loop over our data list, grab the first letter of each item, then go looking for an appropriate array using that letter as a key. We'll add our item to that array, then move on to the next one.

```objc
// Objective-C

- (void)populateData
{
    NSMutableDictionary *sections = [NSMutableDictionary dictionary];
    [self setContents:sections];
    
    NSArray *sourceData = @[ @"Chocolate", @"Pie", @"Carrot", @"Celery", @"Asparagus", @"Apple", @"Banana", @"Grape", @"Melon" ];
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
}
```
```swift
// Swift

func populateData()
{
    let sourceData = [ "Chocolate", "Pie", "Carrot", "Celery", "Asparagus", "Apple", "Banana", "Grape", "Melon"]
    headers = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
    
    for key in headers
    {
        contents[key] = [String]()
    }
    
    for item in sourceData
    {
        let firstLetterRange = item.startIndex..<item.startIndex.advancedBy(1)
        let firstLetter = item[firstLetterRange].uppercaseString
        
        if var section = contents[firstLetter]
        {
            section.append(item)
            contents[firstLetter] = section
        }
        else
        {
            contents[firstLetter] = [ item ]
        }
    }
}
```
Minor differences in code between the languages due to available methods, and Swift's pass-by-value for structs, which Array and Dictionary are. But fundamentally, we grab the first letter, and force it to uppercase just to make sure we get a match, regardless of how well typed the source data is. Then we go find the appropriate array and add the item.

Run the app, and you should see that the items have been successfully grouped, along with a whole lot of empty sections. Let's test this by increasing our source data:

```objc
// Objective-C

NSArray *sourceData = @[ @"Chocolate", @"Pie", @"Carrot", @"Celery", @"Asparagus", @"Apple", @"Banana", @"Grape", @"Melon", @"Strawberry", @"Rutabaga", @"Papaya" ];
```
```swift
// Swift

let sourceData = [ "Chocolate", "Pie", "Carrot", "Celery", "Asparagus", "Apple", "Banana", "Grape", "Melon", "Strawberry", "Rutabaga", "Papaya"]
```
That looks pretty good, but there's one more thing that we should probably address. If you look at the sections that have multiple items, those items aren't shown in any particular order. We processed the list in the order it was provided, and so that is the order that the items went into each array. We'd probably like something a little nicer, like an alphabetical listing.

There are 2 basic solutions in situations like this:
* Sort the source data before bucketing
* After bucketing, sort the bucket contents

If we made the source list alphabetic to begin with, then we wouldn't have this issue. But I think it is more common to sort the bucket contents, so let's do that after we get the data divvied up:

```objc
// Objective-C

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
```
```swift
// Swift

func populateData()
{
    let sourceData = [ "Chocolate", "Pie", "Carrot", "Celery", "Asparagus", "Apple", "Banana", "Grape", "Melon", "Strawberry", "Rutabaga", "Papaya"]
    headers = [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" ];
    
    for key in headers
    {
        contents[key] = [String]()
    }
    
    for item in sourceData
    {
        let firstLetterRange = item.startIndex..<item.startIndex.advancedBy(1)
        let firstLetter = item[firstLetterRange].uppercaseString
        
        if var section = contents[firstLetter]
        {
            section.append(item)
            contents[firstLetter] = section
        }
        else
        {
            contents[firstLetter] = [ item ]
        }
    }
    
    for (key, section) in contents
    {
        contents[key] = section.sort({ $1 > $0 })
    }
}
```
Run the app and verify that the items are now listed alphabetically within each section. Feel free to add more data to confirm that the logic continues to work.

## Summary

Unless you control the source of the data, it is highly unlikely that the data will be provided in a form that makes table view setup easy. It is very common to perform some kind of logic on the data to prepare it for your needs. And it is equally common that the solution is going to require a reasonable amount of work. There aren't 1-liner solutions for all of these problems. You will need to assess what form your data is in, what form you would like it to take, and write code that maps from one to the other. It is also quite possible that you will need to map in both directions, so that you can return modified data in a way that the source expects, but that's beyond the scope of this series.

< [Custom Model Objects](../18.SectionsCustomModelObjects/SectionsCustomModelObjects.md) | >

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
If you found this guide to be helpful, a [tip](http://bit.ly/AW4Cc) would be appreciated.