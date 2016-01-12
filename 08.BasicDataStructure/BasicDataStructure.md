< [Cell Reuse](../07.CellReuse/CellReuse.md) | [Handling Row Taps](../09.HandlingRowTaps/HandlingRowTaps.md) >

# Basic Data Structure

We've seen multiple ways of setting up a view controller for a table view, and we've explored some built-in options to customize the visuals of that table view. But so far we've only really dealt with "Hello World"-caliber data, so let's step our game up a bit here. In the real world, we deal with more than a single string repeated in every cell.

There are a variety of ways to structure your data to drive a table view, and I intend to cover several approaches in this series. But first I would like to focus on what NOT to do; or at least make certain to convey the downsides of a particular technique.

## Setup

Create a new iOS project, using the Single View Application template. Name it anything you want, like BasicDataStructure. Choose your preferred language, device doesn't really matter but let's go with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter. Using your preferred technique, configure the provided view controller for table view use.

And again, before we dive in here, this is an example of what NOT to do. So if you intend to read this chapter, and I hope you do, make sure to read the **whole** chapter. Don't stop early.

## The Hard Way

Our intention is to list out the names of some colors. After you've got your file set up, make your data source methods look like this. And please, don't copy-paste this one, type it all in manually. I want it to hurt.

```objc
// Objective-C

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section
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
```
```swift
// Swift

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    return 50
}

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
    let identifier = "PlainCell"
    
    var optionalCell = tableView.dequeueReusableCellWithIdentifier(identifier)
    if (optionalCell == nil)
    {
        optionalCell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
    }
    
    let cell = optionalCell!
    
    if indexPath.row == 0
    {
        cell.textLabel?.text = "Red"
    }
    else if indexPath.row == 1
    {
        cell.textLabel?.text = "Orange"
    }
    else if indexPath.row == 2
    {
        cell.textLabel?.text = "Yellow"
    }
    else if indexPath.row == 3
    {
        cell.textLabel?.text = "Green"
    }
    else if indexPath.row == 4
    {
        cell.textLabel?.text = "Blue"
    }
    else if indexPath.row == 5
    {
        cell.textLabel?.text = "Magenta"
    }
    
    return cell
}
```
Not very much fun, right? Good, it's not supposed to be. What we have here is a very naive implementation of this method. We are directly inserting a particular piece of text into a particular row, by rigorously looking at each index path that comes along. But it certainly isn't complicated code by any means. It is straightforward, anyone can look at it and see what it does, so that doesn't seem so bad.

Well, the first thing to notice (assuming you actually typed this all out) is that it was a lot to type out. And we've only covered 6 colors! Shoot, UIColor defines 15 shortcut colors, to say nothing of the thousands of combinations possible with various RGB values. Do you want to type all of that out? I sure don't.

Next, how about the order of the items? I've got them listed in a pseudo-rainbow ROY-G-BIV fashion here, but is that what it will always be? Maybe it should be alphabetical instead. Well, now I need to move the "blue" code to the first position, then the "green" to the second position, and so on. And I have to do that manually. That's not fun.

Notice that I've specified 50 rows. You might be thinking that's just a typo. Nope, it was supposed to be 50 when it was first designed, and I had 50 color names to go into the table view. But over time, the designers changed their minds, and we've elected to simplify the list. So I removed the names, but oops, I forgot to correct the number of rows. And if you run the app now, you'll see a whole lot of blank rows, and then if you scroll back and forth enough, you'll eventually start seeing names in the wrong places, due to what we talked about in the [Cell Reuse](../07.CellReuse/CellReuse.md) chapter. But that's just a distraction from the key point here: The number of rows that I tell the table view should be there - 50 - is fundamentally disconnected from the amount of data I have actually provided - 6. Whether I add some data and forget to update the number, or I take some data away and forget to update the number, either way I risk the possibility of forgetting to update the number.

And we're not done yet. Let's say we want to allow the user to delete colors. The user swipes on the "Green" row, but then what happens? We've said that indexPath.row == 3 should be "Green". It's hard-coded right there in the method. So let's pretend this could work, and row 3 is really gone. This means the next row, Blue, should slide up into it's place. But would it still say "Blue"? We've said that whatever is at indexPath.row == 3 should be "Green". Uh oh. So our "Blue" is gone, because we've just moved that to the "Green" row, and we renamed it in the process. What a mess.

And we're still not done yet! Now I would like to print a log of the color every time the user taps a row. So add this delegate method:

```objc
// Objective-C

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
```
```swift
// Swift

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
{
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    if indexPath.row == 0
    {
        print("Red")
    }
    else if indexPath.row == 1
    {
        print("Orange")
    }
    else if indexPath.row == 2
    {
        print("Yellow")
    }
    else if indexPath.row == 3
    {
        print("Green")
    }
    else if indexPath.row == 4
    {
        print("Blue")
    }
    else if indexPath.row == 5
    {
        print("Magenta")
    }
}
```
This code feels really familiar, doesn't it? Instead of sticking the string into a label, we're sticking it into a log value. But it is still the same if/else if/else if structure. Anytime you are repeating this much code, you should probably take a step back and decide if this is the right way to go about things. And I'm about to make your day even worse:

```objc
// Objective-C

if ([indexPath row] == 0)
{
    [[cell textLabel] setText:@"Orange"];
}
else if ([indexPath row] == 1)
{
    [[cell textLabel] setText:@"Red"];
}
...
```
```swift
// Swift

if indexPath.row == 0
{
    cell.textLabel?.text = "Orange"
}
else if indexPath.row == 1
{
    cell.textLabel?.text = "Red"
}
...
```
I just reversed the order of the first two rows, but only in cellForRowAtIndexPath. Now if you run the app and tap on those two rows, you'll get the wrong color in the log. We didn't make the corresponding change in didSelectRow, so now they are out of sync.

You might be thinking to yourself that you won't make these kinds of mistakes. You'll always remember to make all of the changes that are needed everywhere. But A) You're wrong, and B) you might not be the one making the changes. You might be working on a team, you're out of the office, so someone else has to make the fix for you. This other helpful person is not aware of the many places that this if/else if/else if code needs to be changed, so they make the obvious change of getting the list to display properly, not realizing they've just screwed up the row selection handling. Additionally, the person making the change could easily be you in 6 months, after you've had a variety of other projects to work on, and you've long since forgotten about how this code works.

Some things can only be learned through experience, but I hope I have convinced you that this is the wrong way to power your table view. Let's recap some pitfalls:
* numberOfRows is disconnected from the data structure, which can lead to an incorrect value
* Inflexible structure. Changes require a lot of work.
* Lots of typing. The more data you have, the more typing there will be.
* Lots of repeated code. That's code smell.
* Lots of _separate_, repeated code. Changes in one group do not affect the other group.

In summary: So, so many ways for your various delegate and data source methods to get out of sync with each other. It is a situation just begging for bugs.

## The Easy Way

Fortunately there are better ways to set the data up that avoid all (or at least most) of these pitfalls. Many ways, actually, and I intend to cover several of them in this series, but for now let us look at a humble array. Add an array property to our class:

```objc
// Objective-C

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;

@end
```
```swift
// Swift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var contents = [String]()
...
```
A simple list of strings. Now let's populate it in viewDidLoad:
```objc
// Objective-C

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setContents:@[ @"Red", @"Orange", @"Yellow", @"Green", @"Blue", @"Magenta"]];
}
```
```swift
// Swift

override func viewDidLoad()
{
    super.viewDidLoad()
    
    contents = [ "Red", "Orange", "Yellow", "Green", "Blue", "Magenta" ]
}
```
Already this looks nicer. But what does it really do for us? Well, let's start with our row count. Remember our mistaken 50 number? Instead of hard-coding a particular number, I could make it depend on our actual data. In this case, a count of the array's contents:

```objc
// Objective-C

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [[self contents] count];
}
```
```swift
// Swift

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
{
    return contents.count
}
```
I can add as many colors as I want, or take away some, and this value will remain accurate. So we've dramatically improved the quality of our code, and we're not even done yet. Let's get Big Payoff #1, removing a bunch of annoying code:

```objc
// Objective-C

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
```
```swift
// Swift

func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
    let identifier = "PlainCell"
    
    var optionalCell = tableView.dequeueReusableCellWithIdentifier(identifier)
    if (optionalCell == nil)
    {
        optionalCell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
    }
    
    let cell = optionalCell!
    
    let rowValue = contents[indexPath.row];
    
    cell.textLabel?.text = rowValue
    
    return cell
}
```
Goodbye, if/else if/else if/else if.... We are now pulling our strings out of the array, and passing them along to the table cell. Not only is this substantially less code, but notice a characteristic here: does this code care how many rows we have? No. We could have 50 rows, we could have 5000 rows, and this code will remain the same. Also notice that this code doesn't care what order the colors are in. It will simply take whatever is in the array and show it. If I want to change the sort order, I certainly could do so (in a different method), and again this code would remain the same. So many bugs squashed! And now for Big Payoff #2:
```objc
// Objective-C

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    NSLog(@"%@", rowValue);
}
```
```swift
// Swift

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
{
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
    let rowValue = contents[indexPath.row];
    
    print(rowValue)
}
```
That sound you just heard was the last of our if/else if code dying a painful death. Not only have we again removed a lot of code, but we have again improved the quality. This method retrieves the exact same value that cellForRow does (how it does so could be further improved, but we'll cover that in a later chapter), so we can be confident that the log value will be correct. No more getting out of sync just because we forgot to make a change somewhere.

## Summary

More than half of this chapter was spent telling you what **not** to do. And that ratio isn't an accident; notice that doing things in a good way - I won't even say a GREAT way, simply a good way - is so much easier than doing things the bad way. We've established a clear delineation between our data and our delegate methods. If the data needs to be changed, you go to one spot, change it, and that's all you have to do. The table view delegate methods don't care what strings the array has in it, so they no longer need to be modified when the strings change. That's a win for you, and it's a win for your coworker making changes while you're on vacation.

Observe how much we simplified our delegate methods once we established a proper data structure. And that's going to be a good guideline going forward: If you can put the work into defining your data structure up front with your table view in mind - and this may mean running some preprocessing logic on your raw data - you can dramatically streamline and simplify your delegate methods.

< [Cell Reuse](../07.CellReuse/CellReuse.md) | [Handling Row Taps](../09.HandlingRowTaps/HandlingRowTaps.md) >

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
If you found this guide to be helpful, a [tip](http://bit.ly/AW4Cc) would be appreciated.