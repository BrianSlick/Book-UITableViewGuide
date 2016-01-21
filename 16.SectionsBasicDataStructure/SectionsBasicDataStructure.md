< [Section Headers and Footers](../15.SectionHeadersFooters/SectionHeadersFooters.md) | [Another Basic Data Structure](../17.SectionsAnotherBasicDataStructure/SectionsAnotherBasicDataStructure.md) >

# Multiple Sections: Basic Data Structure

We've already done a [Basic Data Structure](../08.BasicDataStructure/BasicDataStructure.md) chapter, so you may be curious why we're seeing another one. Put simply, dealing with multiple sections adds a fair amount of complexity to your code, with a wide variety of ways to do things well, and probably a wider variety of ways to do things poorly. As in the first chapter, we will first look at bad ways of doing this, and then talk about how to establish a good foundation. Because there are so many ways to work with sections, additional techniques will be found in later chapters.

The basic task we will be tackling in this chapter is to make a simplified grocery list. We will have a collection of fruits, vegetables, and sweets, and we'll want to group those together. Like so:
>Fruits: Apple, Banana, Grape
Vegetables: Carrot, Celery
Sweets: Chocolate

3, 2, 1. Different kinds of items, different amounts of each item. Let's begin.

## Setup

Create a new iOS project, using the Single View Application template. Name it anything you want, like SectionsStructure. Choose your preferred language, device doesn't really matter but let's go with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter. Using your preferred technique, configure the provided view controller for table view use.

## The Bad Way

Instead of providing all of the initial code at once, let's build this one as we go.

As stated, we want 3 sections:

```objc
// Objective-C

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
```
```swift
// Swift

func numberOfSectionsInTableView(tableView: UITableView) -> Int
{
    return 3
}
```

Let's go ahead and include headers for each one:

```objc
// Objective-C

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Fruits";
    }
    else if (section == 1)
    {
        return @"Vegetables";
    }
    else if (section == 2)
    {
        return @"Sweets";
    }
    
    return nil;
}
```
```swift
// Swift

func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
{
    if section == 0
    {
        return "Fruits"
    }
    else if section == 1
    {
        return "Vegetables"
    }
    else if section == 2
    {
        return "Sweets"
    }
    
    return nil
}
```
If you read the first [Basic Data Structure](../08.BasicDataStructure/BasicDataStructure.md) chapter, then your danger sense should already be tingling. If not, well, here there be monsters.

Now we need our number of rows:

```objc
// Objective-C

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    else if (section == 1)
    {
        return 2;
    }
    else if (section == 2)
    {
        return 1;
    }
    
    return 0;
}
```
```swift
// Swift

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    if section == 0
    {
        return 3
    }
    else if section == 1
    {
        return 2
    }
    else if section == 2
    {
        return 1
    }
    
    return 0
}
```
It sure feels like we've typed a lot of this before.

Finally we can populate our cells (cell recycling omitted just because this will be lengthy enough already):

```objc
// Objective-C

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Plain"];
    
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    
    NSString *text = nil;
    
    if (section == 0) {
        if (row == 0) {
            text = @"Apple";
        }
        else if (row == 1) {
            text = @"Banana";
        }
        else if (row == 2) {
            text = @"Grape";
        }
    }
    else if (section == 1) {
        if (row == 0) {
            text = @"Carrot";
        }
        else if (row == 1) {
            text = @"Celery";
        }
    }
    else if (section == 2) {
        if (row == 0) {
            text = @"Chocolate";
        }
    }
    
    [[cell textLabel] setText:text];
    
    return cell;
}
```
```swift
// Swift

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
    let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Plain")
    
    let section = indexPath.section
    let row = indexPath.row
    
    var text = ""
    
    if section == 0 {
        if row == 0 {
            text = "Apple"
        }
        else if row == 1 {
            text = "Banana"
        }
        else if row == 2 {
            text = "Grape"
        }
    }
    else if section == 1 {
        if row == 0 {
            text = "Carrot"
        }
        else if row == 1 {
            text = "Celery"
        }
    }
    else if section == 2 {
        if row == 0 {
            text = "Chocolate"
        }
    }
    
    cell.textLabel?.text = text
    
    return cell;
}
```

Well, that was no fun at all. But at least run it to make sure we accomplished the goal. Yay.

What we see here are the same weaknesses that were demonstrated in the first chapter, only multiplied several times over. And it just gets worse. We would need to repeat a lot of this code to handle row taps, for example. Now that we've gone through the chapters on deleting rows, inserting rows, and reordering rows, I hope that you now have a greater appreciation for the major downsides of doing this. We have hard-coded absolutely everything, which means this is a static structure that cannot be modified by the user. It's no picnic for developers to modify either.

Let's never do this again.

## A Better Way

Putting some quality time into planning out your data structure will go a long way towards making your table view life easier. The solution presented in the first chapter was to use an array of strings instead of the if/else if/else conditions. That can work here too, but we no longer have a single list of strings, we want them to be grouped.

Fortunately, arrays can hold more than just strings; they can hold other arrays, too. We will group our data into arrays, very similarly to the first chapter. Then, we will add these separate arrays into the main array, giving us an array of arrays. Specifically, an array, of arrays, of strings.

Let's build our data structure first, in viewDidLoad. And we need our familiar array property, too:

```objc
// Objective-C

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;

@end

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *fruits = @[ @"Apple", @"Banana", @"Grape" ];
    NSArray *vegetables = @[ @"Carrot", @"Celery" ];
    NSArray *sweets = @[ @"Chocolate" ];
    
    [self setContents:@[ fruits, vegetables, sweets ]];
}
```
```swift
// Swift

@IBOutlet var tableView: UITableView!
var contents = [[String]]()

override func viewDidLoad()
{
    super.viewDidLoad()
    
    let fruits = [ "Apple", "Banana", "Grape" ]
    let vegetables = [ "Carrot", "Celery" ]
    let sweets = [ "Chocolate" ]
    
    contents = [ fruits, vegetables, sweets ]
}
```
>Note: We will discuss modification in a later chapter, so for now non-mutable arrays are fine.

The number of elements in this main array is our section count, so let's update update that method accordingly:

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
This is exactly what we did before, except this time we are answering the section question instead of the row question.

Speaking of the row question, we can update that, too, to reflect our data structure. The row count is the count of the appropriate array inside the main array. First we retrieve that array, then we count it:

```objc
// Objective-C

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSArray *groupArray = [[self contents] objectAtIndex:section];
    
    return [groupArray count];
}
```
```swift
// Swift

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    let groupArray = contents[section]
    
    return groupArray.count
}
```
Lastly we update cellForRow to grab the appropriate string. It will be a similar exercise: first we grab the array inside the contents, then we grab the string.

```objc
// Objective-C

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Plain"];
    
    NSArray *groupArray = [[self contents] objectAtIndex:[indexPath section]];
    NSString *text = [groupArray objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:text];
    
    return cell;
}
```
```swift
// Swift

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
    let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Plain")
    
    let groupArray = contents[indexPath.section]
    let text = groupArray[indexPath.row]
    
    cell.textLabel?.text = text
    
    return cell;
}
```
Here we see how to pull apart an index path's components. We've seen the row component a bit before, now we're seeing the the section component as well. Given the way we've set up our array, the section represents the index in the main content array. The row represents the index in the sub-array. If we were given (0,0), that means we grab the first array, and then the first string in that array.

Notice how much less code this is, and consider how many avenues for errors we have removed. Let's test it by adding data:

```objc
// Objective-C

NSArray *fruits = @[ @"Apple", @"Banana", @"Grape", @"Melon" ];
NSArray *vegetables = @[ @"Carrot", @"Celery", @"Asparagus" ];
NSArray *sweets = @[ @"Chocolate", @"Pie" ];
```
```swift
// Swift

let fruits = [ "Apple", "Banana", "Grape", "Melon" ]
let vegetables = [ "Carrot", "Celery", "Asparagus" ]
let sweets = [ "Chocolate", "Pie" ]
```
Run the app and see the new contents. Notice that to add data, all we did was... add data. We didn't have to go swimming through all kinds of if/else statements in numerous delegate methods. Once the data structure is defined, and the delegate methods are setup to use that data structure, then the amount of data involved really doesn't cause any other changes. If we want 50 fruits now, all we do is modify that one line of code.

## But Not a Great Way...

We overlooked the headers. That is still a hard-coded if/else structure, and we'd like to avoid that. But the question becomes, where to put it? It doesn't really fit with the rest of our data.

You might be thinking to yourself something like...

>hey, wait a minute... I can put different _kinds_ of objects into an array! I could add a string for the header, then an array for that section, then another string for the next header, and another array, and so on. My array will just be a pattern of string, array, string, array. Easy!

No. Just no.

From a technical standpoint, sure it could be done. From a sanity standpoint, generally speaking if you are throwing different kinds of objects into a single container, you probably should take a step back and rethink things. Right off the bat, how many sections would this table have? We've added 3 strings and 3 arrays to our contents, so the total count there would be 6. But we don't want 6, we want 3, so we need to divide the count in half. That is only the first ding in what will eventually be some highly dented armor.

Let's add another array for the headers, so at least we are keeping with the theme:
```objc
// Objective-C

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;
@property (nonatomic, strong) NSArray *headers;

@end

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *fruits = @[ @"Apple", @"Banana", @"Grape", @"Melon" ];
    NSArray *vegetables = @[ @"Carrot", @"Celery", @"Asparagus" ];
    NSArray *sweets = @[ @"Chocolate", @"Pie" ];
    
    [self setContents:@[ fruits, vegetables, sweets ]];
    
    [self setHeaders:@[ @"Fruits", @"Vegetables", @"Sweets" ]];
}
```
```swift
// Swift

@IBOutlet var tableView: UITableView!
var contents = [Array<String>]()
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
```
And update the corresponding delegate method:

```objc
// Objective-C

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    return [[self headers] objectAtIndex:section];
}
```
```swift
// Swift

func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?
{
    return headers[section]
}
```
Run the app and verify that everything still works.

Although the code is many times better now than when we started, we still have a fundamental problem that we're actually not going to solve in this chapter. We have 2 separate arrays governing our data structure. For example, the number of sections - 3 - could be provided by either array. And that is exactly the problem. If I add a piece of data to either array, that array would have 4 items, which means they no longer agree on the number of sections. So which array should be answering that question? Hard to say which one is more important. Some of the delegate methods work with one array, some work on the other. This is an out-of-sync problem just waiting to happen.

We'll see an alternative, somewhat better approach in the next chapter. Here, we simply need to face the consequences of our decision. If we weren't using headers, then there is no issue here. We'd only need the contents array, and the grouped array structure would be just fine.

A couple of key takeaways here:
* Don't split data up into parallel containers. You cannot easily keep multiple arrays in sync. You should instead seek to utilize a single master container as much as possible. For example, you would not want to have 1 array with "first names" and another array with "last names". You would instead want to combine the data somehow, perhaps with a model object, and put those into only a single array.
* Consider **all** of your table view needs before deciding on a data structure. Structures can be changed, and it's not usually _that_ bad to work around, but the needs of the table view will dictate which data structures are better choices than others.

## One Last Tip

Let's add our familiar log upon tapping a row:

```objc
// Objective-C

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *groupArray = [[self contents] objectAtIndex:[indexPath section]];
    NSString *text = [groupArray objectAtIndex:[indexPath row]];
    
    NSLog(@"text: %@", text);
}
```
```swift
// Swift

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
{
    let groupArray = contents[indexPath.section]
    let text = groupArray[indexPath.row]
    
    print(text)
}
```
Notice that the first 2 lines are exactly the same in cellForRow. That's actually been the case all along, but up until now we've been using a 1-liner of code to retrieve our text. Now it is 2. Repeated code in multiple places is usually a sign of an opportunity to pull common code out into a separate method. Let's do that:

```objc
// Objective-C

- (NSString *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *groupArray = [[self contents] objectAtIndex:[indexPath section]];
    NSString *text = [groupArray objectAtIndex:[indexPath row]];
    
    return text;
}
```
```swift
// Swift

func itemAtIndexPath(indexPath: NSIndexPath) -> String
{
    let groupArray = contents[indexPath.section]
    let text = groupArray[indexPath.row]
    
    return text
}
```
Our row tap delegate then changes to:

```objc
// Objective-C

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = [self itemAtIndexPath:indexPath];
    
    NSLog(@"text: %@", text);
}
```
```swift
// Swift

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
{
    let text = itemAtIndexPath(indexPath)
    
    print(text)
}
```
You can do the same thing in cellForRow. Admittedly, in this particular case, we aren't talking about tons of code savings. But what we have done is remove some of the _knowledge_ of the data structure from the delegate methods. If we change our mind about the structure, as we will in the next chapter, we'd have to run around and update each delegate method with code appropriate for the new structure. Now, these 2 delegate methods no longer care about that structure. All they do is provide an index path and get back a string. They no longer need to know about how to retrieve that string; that logic has been moved to one place.

## Summary

This chapter demonstrates for a second time the evils of hard-coding your structure. Any problems we had back in single-section days only get multiplied here in modern multiple-section times.

And it's also worth pointing out that we didn't wind up with a great technique here, merely an ok one. You cannot always count on being able to take a simplified example and just make it bigger. But, you can't always count on being able to craft the perfect solution either. Some times you just need to minimize the potential for problems, and ship it.

The bottom line is that you want your delegate methods to work with your data structure, not _define_ your data structure.

< [Section Headers and Footers](../15.SectionHeadersFooters/SectionHeadersFooters.md) | [Another Basic Data Structure](../17.SectionsAnotherBasicDataStructure/SectionsAnotherBasicDataStructure.md) >

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
If you found this guide to be helpful, a [tip](http://bit.ly/AW4Cc) would be appreciated.