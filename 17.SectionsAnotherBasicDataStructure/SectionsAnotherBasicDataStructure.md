< [Basic Data Structure](../16.SectionsBasicDataStructure/SectionsBasicDataStructure.md) | >

# Multiple Sections: Another Basic Data Structure

In this chapter we will explore a solution (note: this is not _the_ solution, merely _a_ solution; there are many possible routes to take) to the problem introduced in last chapter. When we finished up, our section headers were in one array, our section contents were in another array, and those two arrays were not inherently linked in any way. Our solution here will reduce, though not completely remove, the amount of disconnect between those elements.

## Setup

Create a new iOS project, using the Single View Application template. Name it anything you want, like AnotherSectionsStructure. Choose your preferred language, device doesn't really matter but let's go with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter. Using your preferred technique, configure the provided view controller for table view use.

## Dictionary of Arrays

If you think about what we are trying to accomplish, there are 2 key goals: 1) we want to group our data by type ("Fruits"), and 2) we want those groups to be in a particular order. We grouped our data into arrays, and then we placed those arrays into another array to establish our order. But arrays don't have a concept of "type" (in the way we mean here), or this case, "name". That is an extra piece of information that the array simply doesn't have a clean mechanism to store. In the previous chapter, we worked around that by keeping a list of the types in a separate array.

We are not limited to arrays. Any kind of a collection, whether that be provided by Apple or something you come up with on your own, could potentially be used here. (The amount of logic required to use any particular collection is a whole other matter...) In this case, the desire to group by name suggests that we explore another container: dictionary. A dictionary stores data on a key-value basis. The key could be the name of our section, and the value could be our group array. 3 different keys, so 3 different group arrays. Sounds promising, but there is a catch: dictionaries do not provide order.

We have one collection type - array - that provides order but no names. And we have another collection type - dictionary - that provides names but no order. Since we want names _and_ order, this means we cannot use an array or a dictionary alone. Perhaps we could use them together. But how? Well, if we use the dictionaries to store key-value pairs, that establishes our grouped structure. Then we can use an array to maintain order, but an array of what? The keys, or for our usage here, the section headers. So we will store data in our dictionary using the section headers as keys, and then we will store the section headers - in desired order - in an array.

Let's start exactly where we left off in the last chapter, then we will make changes to the structure to reflect what we just discussed. Make your view controller look like this:

```objc
// Objective-C

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

```
```swift
// Swift

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    var contents = [[String]]()
    var headers = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let fruits = [ "Apple", "Banana", "Grape", "Melon" ]
        let vegetables = [ "Carrot", "Celery", "Asparagus" ]
        let sweets = [ "Chocolate", "Pie" ]
        
        contents = [ fruits, vegetables, sweets ]
        headers = [ "Fruits", "Vegetables", "Sweet" ]
    }
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> String
    {
        let groupArray = contents[indexPath.section]
        let text = groupArray[indexPath.row]
        
        return text
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return contents.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return headers[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let groupArray = contents[section]
        
        return groupArray.count
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
First, let's convert our contents from an array to a dictionary. I'm switching to mutable just because I prefer the semantics, but mutable-vs-non-mutable is not relevant to the big picture.

```objc
// Objective-C

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *contents;
@property (nonatomic, strong) NSMutableArray *headers;

@end
```
```swift
// Swift

@IBOutlet var tableView: UITableView!
var contents = [String: [String]]()
var headers = [String]()
```
Your file will light up with lots of issues after making this change. We'll get them fixed before we're done.

The most significant changes need to happen where we populate our data in viewDidLoad. Let's begin there and define our new structure:

```objc
// Objective-C

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
```
```swift
// Swift

override func viewDidLoad()
{
    super.viewDidLoad()
    
    let fruitKey = "Fruit"
    let vegetableKey = "Vegetable"
    let sweetKey = "Sweet"
    
    let fruits = [ "Apple", "Banana", "Grape", "Melon" ]
    let vegetables = [ "Carrot", "Celery", "Asparagus" ]
    let sweets = [ "Chocolate", "Pie" ]
    
    contents[fruitKey] = fruits
    contents[vegetableKey] = vegetables
    contents[sweetKey] = sweets
    
    headers.append(fruitKey)
    headers.append(vegetableKey)
    headers.append(sweetKey)
}
```
>Note: Yes, all of this could have been done in a more compact fashion. But there are some edits that can be made that are more easily done this way.

The first thing we do is declare some constants for the keys. Nothing will ruin your dictionary day faster than a typo in a key name, either setting or retrieving. Then we declare the same content arrays that we had in the last chapter. We then add those arrays to the dictionary using the keys. Finally we add the keys to the header array in the order we want them to appear.

We can't run the app until we repair the remaining issues. First is our numberOfRows method:

```objc
// Objective-C

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [[self headers] objectAtIndex:section];
    NSArray *groupArray = [[self contents] objectForKey:key];
    
    return [groupArray count];
}
```
```swift
// Swift

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    let key = headers[section]
    if let groupArray = contents[key]
    {
        return groupArray.count
    }
    
    return 0
}
```
Before, we referenced the groupArray by index in the main array. Now, we must first grab the section key based on the section index, then we can retrieve the appropriate groupArray from the dictionary. Swift has an additional safety check, as it is entirely possible that there is no value for that key in the dictionary.

This change also hints at how we need to fix the last remaining issue in itemAtIndexPath. We again need to change how we grab the groupArray:

```objc
// Objective-C

- (NSString *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[self headers] objectAtIndex:[indexPath section]];
    NSArray *groupArray = [[self contents] objectForKey:key];
    NSString *text = [groupArray objectAtIndex:[indexPath row]];
    
    return text;
}
```
```swift
// Swift

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
```
We have now repaired all of the issues, so you can run the app and verify that it still works. Notice that we did not have to fix anything in cellForRow or didSelectRow. This is thanks to our itemAtIndexPath method, which allowed us to focus most of the impact of the structural change to only one method.

This is all we technically needed to do to make the data structure change, but now let's consider the impact of our decision here. First, let's look at our number of sections:

```objc
// Objective-C

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self contents] count];
}
```
```swift
// Swift

func numberOfSectionsInTableView(tableView: UITableView) -> Int
{
    return contents.count
}
```
Notice we are counting the dictionary, not the array. Does that matter? That depends. Let's say that today we don't want to show the vegetables. I could remove the vegetable array from the dictionary, but then the header array still has it, if I'm not paying attention. Not ideal, as the dictionary would have 2 items, but the array still has 3. If you have more keys than data, that's a potential problem as some of those keys will turn up empty. What if we go the other way though, and only remove the key?

```objc
// Objective-C

[keys addObject:fruitKey];
//[keys addObject:vegetableKey];
[keys addObject:sweetKey];
```
```swift
// Swift

headers.append(fruitKey)
//headers.append(vegetableKey)
headers.append(sweetKey)
```
Again we are in a situation where the count of the array and the count of the dictionary don't match. But is that necessarily a problem? We are now saying there are only 2 headers, so there should be only 2 sections. Yes, the vegetable array is still in the dictionary, but who cares? Nobody will be asking for the vegetable key.

We still have the fundamental problem from the previous chapter, that being 2 containers that could disagree over the contents. But the advantage by using the dictionary is that it doesn't matter how many items are in the dictionary. There could be 1000 items, but if we only want to show 2 sections, all we need to do is use 2 keys. Sure, we're carrying around 998 items that we don't need, and in a broad sense you'd like to minimize that. But as far as our table view is concerned, we'll only show 2 sections, and nothing bad will otherwise happen. So let's switch our numberOfSections to count the header array instead:

```objc
// Objective-C

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self headers] count];
}
```
```swift
// Swift

func numberOfSectionsInTableView(tableView: UITableView) -> Int
{
    return headers.count
}
```
Run the app and you should only see 2 sections.

Incidentally, this is why I used as many lines as I did in viewDidLoad. It's really easy to comment out one of the key lines this way. With everything on one line, you've got to delete or move text out of the way in order to get it out of the structure.

The basic premise with this approach is to fully load the dictionary no matter what. Then you can make decisions about which sections appear purely by modifying the header array, so a change that is required in only 1 place. The header array is the master, and determines how many sections there are. In the previous chapter, the section would have needed to be removed from 2 places, and problems would have occurred if the change was not performed in both places.

There is an alternate way of looking at this, too. Notice that we lost the "Vegetable" header. So a user looking at the app has no idea that we even care about vegetables. In many cases, that may be a perfectly acceptable UI. But in other cases, we'd like the user to know that we do care, but there simply aren't any available. We'd still like to see the header, but there won't be any vegetable contents. All that requires is commenting a different line:

```objc
// Objective-C

[items setObject:fruits forKey:fruitKey];
//[items setObject:vegetables forKey:vegetableKey];
[items setObject:sweets forKey:sweetKey];

[keys addObject:fruitKey];
[keys addObject:vegetableKey];
[keys addObject:sweetKey];
```
```swift
// Swift
contents[fruitKey] = fruits
//contents[vegetableKey] = vegetables
contents[sweetKey] = sweets

headers.append(fruitKey)
headers.append(vegetableKey)
headers.append(sweetKey)
```
>You will have a warning about unused variables, but for our purposes here you can ignore that. In general, however, fix your warnings.

Run the app, and you'll see all 3 headers, but the vegetables one is empty. So once again the array and the dictionary disagree on the quantity of contents, but not only did it _not_ cause a problem, we used it to our advantage.

I've only discussed the example of removing data here, but what about rearranging data? Maybe the sweets should be listed first. Here, I simply change the order that I add the keys to the header array. The dictionary is not affected. In the previous chapter, again I would have needed to make that change in 2 places or there would have been errors.

## Summary

We have now explored 2 distinct data structures for displaying exactly the same contents in a table view. And that really does matter for us as developers: there are a variety of ways of writing our code that don't affect the final outcome of what the user sees. What matters is understanding the pros/cons of any given approach, and making the best decision given what the table view needs to do, and what our future data needs might be.


< [Basic Data Structure](../16.SectionsBasicDataStructure/SectionsBasicDataStructure.md) | >

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
If you found this guide to be helpful, a [tip](http://bit.ly/AW4Cc) would be appreciated.