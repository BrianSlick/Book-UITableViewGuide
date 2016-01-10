# Basic Data Structure

We've seen multiple ways of setting up a view controller for a table view, and we've explored some built-in options to customize the visuals of that table view. But so far we've only really dealt with "Hello World"-caliber data, so let's step our game up a bit here. In the real world, we deal with more than a single string repeated in every cell.

There are a variety of ways to structure your data to drive a table view, and I intend to cover several approaches in this series. But first I would like to focus on what NOT to do; or at least make certain to convey the downsides of a particular technique.

Create a new iOS project, using the Single View Application template. Name it anything you want, like BasicDataStructure. Choose your preferred language, device doesn't really matter but let's go with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter.

And again, before we dive in here, this is an example of what NOT to do. So if you intend to read this chapter, and I hope you do, make sure to read the **whole** chapter. Don't stop early.

We will use the Storyboard and the provided view controller, so configure it for table view usage using your preferred technique.

Our intention is to list out the names of some colors. After you've got your file set up, make your data source methods look like this. And please, don't copy-paste this one, type it all in manually. I want it to hurt.

```objc
// Objective-C

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
    
    var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
    if (cell == nil)
    {
        cell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
    }
    
    if indexPath.row == 0
    {
        cell?.textLabel?.text = "Red"
    }
    else if indexPath.row == 1
    {
        cell?.textLabel?.text = "Orange"
    }
    else if indexPath.row == 2
    {
        cell?.textLabel?.text = "Yellow"
    }
    else if indexPath.row == 3
    {
        cell?.textLabel?.text = "Green"
    }
    else if indexPath.row == 4
    {
        cell?.textLabel?.text = "Blue"
    }
    else if indexPath.row == 5
    {
        cell?.textLabel?.text = "Magenta"
    }
    
    return cell!
}
```
Not very much fun, right? Good, it's not supposed to be. What we have here is a very naive implementation of this method. We are directly inserting a particular piece of text into a particular row, by rigorously looking at each index path that comes along. But it certainly isn't complicated code by any means. Straightforward, anyone can look at it and see what it does, so that doesn't seem so bad.

Well, the first thing to notice (assuming you actually typed this all out) is that it was a lot to type out. And we've only covered 6 colors! Shoot, UIColor defines 15 shortcut colors, to say nothing of the thousands of combinations possible with various RGB values. Do you want to type all of that out? I sure don't.

Next, how about the order of the items? I've got them listed in a pseudo-rainbow ROY-G-BIV fashion here, but is that what it will always be? Maybe it should be alphabetical instead. Well, now I need to move the "blue" code to the first position, then the "green" to the second position, and so on. And I have to do that manually. That's not fun.

Notice that I've specified 50 rows. You might be thinking that's just a typo. Nope, it was supposed to be 50 when I first designed it, and I had 50 color names to go into the table view. But over time, the designers changed their minds, and we've elected to simplify the list. So I removed the names, but oops, I forgot to correct the number of rows. And if you run the app now, you'll see a whole lot of blank rows, and then if you scroll back and forth enough, you'll eventually start seeing names in the wrong places, due to what we talked about in the [Cell Reuse](../07.CellReuse/CellReuse.md) chapter. But that's just a distraction from the key point here: The number of rows that I tell the table view should be there - 50 - is fundamentally disconnected from the amount of data I have actually structured - 6. Whether I add some data and forget to update the number, or I take some data away and forget to update the number, either way I risk the possibility of forgetting to update the number.

And we're not done yet. Let's see we want to allow the user to delete colors. The user swipes on the "Green" row, but then what happens? We've said that indexPath.row == 3 should be "Green". It's hard-coded right there in the method. So let's pretend this could work, and so row 3 is really gone. This means the next row, Blue, should slide up into it's place. But would it still say "Blue"? We've said that whatever is at indexPath.row == 3 should be "Green". Uh oh. So our "Blue" is gone, because we're just moved that to the "Green" row, and we renamed it in the process. What a mess.

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
    cell?.textLabel?.text = "Orange"
}
else if indexPath.row == 1
{
    cell?.textLabel?.text = "Red"
}
...
```
I just reversed the order of the first two rows, but only in cellForRowAtIndexPath. Now if you run the app and tap on those two rows, you'll get the wrong color in the log. We didn't make the corresponding change in didSelectRow, so now they are out of sync.

You might be thinking to yourself that you won't make these kinds of mistakes. You'll always remember to make all of the changes that are needed everywhere. But A) You're wrong, and B) you might not be the one making the changes. You might be working on a team, you're out of the office, so someone else has to make the fix for you. This other helpful person is not aware of the many places that this if/else if/else if code needs to be changed, so they make the obvious change of getting the list to display properly, not realizing they've just screwed up the row selection handling. Additionally, the person making the change could easily be you in 6 months, after you've had a variety of other projects to work on, and you've long since forgotten about how this code works.

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick