# Handling Row Taps

We have already seen row tapping briefly in a couple previous chapters. We shall bring it into focus here, describe how to tailor some behaviors, and cover the accessory tapping that was mentioned in the table cell chapter.

Create a new iOS project, using the Single View Application template. Name it anything you want, like HandlingRowTaps. Choose your preferred language, device doesn't really matter but let's go with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter. Using your preferred technique, configure the provided view controller for table view use.

We will continue on with the list of colors that we saw in the [Basic Data Structure](../08.BasicDataStructure/BasicDataStructure.md) chapter, so make your view controller look like this:

```objc
// Objective-C

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *contents;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setContents:@[ @"Red", @"Orange", @"Yellow", @"Green", @"Blue", @"Magenta"]];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    NSLog(@"%@", rowValue);
}

@end

```
```swift
// Swift

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var tableView: UITableView!
    var contents = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        contents = [ "Red", "Orange", "Yellow", "Green", "Blue", "Magenta" ]
    }
    
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return contents.count
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
        
        let rowValue = contents[indexPath.row];
        
        cell.textLabel?.text = rowValue
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let rowValue = contents[indexPath.row];
        
        print(rowValue)
    }
}
```
The focus of this chapter will be the delegate method we've already seen - didSelectRowAtIndexPath - and we'll also introduce a few new ones.

First, let's comment out this method altogether so that we see what it does.

```objc
// Objective-C

//- (void)tableView:(UITableView *)tableView
//didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
//    
//    NSLog(@"%@", rowValue);
//}
```
```swift
// Swift

//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//    {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        
//        let rowValue = contents[indexPath.row];
//        
//        print(rowValue)
//    }
```
Run the app, and tap on some rows. 2 key things to observe:
1. The row highlights in gray.
2. The row remains highlighted until you select another one, which in turn remains highlighted.

Let's talk about color first. Like everything else visual, row highlighting received a makeover for iOS 7. The gray that we see here used to be blue. But it actually was configurable, and you could choose between blue, gray, and nothing at all. As of iOS 7, the blue is gone, and Apple introduced a new "default" setting, which is the gray. So let's take a quick look at how to set that here, where the cell is created:

```objc
// Objective-C

if (cell == nil)
{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
```
```swift
// Swift

if (optionalCell == nil)
{
    optionalCell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
    optionalCell?.selectionStyle = .None
}
```
Run the app and tap around, and you'll no longer see the gray highlight. Now it is important to note that even though we've turned off the gray highlight, the row _is_ still being selected.

We can prove that by uncommenting didSelectRowAtIndexPath. Run the app again, tap some rows again, but watch the logs. Even though you don't see anything happening in the app, your logs confirm that the table is receiving the taps, and passing that information along to your delegate method. It's not horribly uncommon to want to know that the user tapped on a row while not wanting to see the standard row highlight, so this is how it is accomplished.

Comment out the selectionStyle line, as we won't be using it for now. Re-run the app to verify that you see the gray highlight again.

Take a look at the didSelectRowAtIndexPath, and notice that the very first thing I do there is tell the table view to deselect the row, using the same indexPath parameter that came in. Comment out just that one line, and run the app again.

```objc
// Objective-C

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    NSLog(@"%@", rowValue);
}
```
```swift
// Swift

func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
{
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
   let rowValue = contents[indexPath.row];
        
   print(rowValue)
}
```
Log values in the console confirm that we are running through this method, and this time when you tap on a row it remains highlighted just like before. The key takeaway here is that table views don't turn off your rows automatically. What you select will remain selected until you turn it off.

Whether or not to deselect is a design choice, but Apple does provide example usage in the mail app. On your phone, (portrait if you have a big phone) tap a message row. Note you see the highlight, then the message slides in. When you go back, you still see the highlight, then it turns off. Apple does this so you can see which message you tapped in the first place.

Now on your iPad, (or big phone) in landscape do the same thing. Notice this time that the tapped row remains highlighted, as the message is shown on the right side of the screen.

And finally if you go to Bluetooth or Wi-Fi in the Settings app, and choose a different device or network, you'll see an example of highlighting and then quickly turning back off. All 3 slightly different use cases, all controlled with some combination of this delegate method and the deselect method.

You may uncomment the deselectRowAtIndexPath line. Run the app again to make sure that rows turn off after selection.

As I said before with the selectionStyle, even if we turn off the _appearance_ of a selection, the row is actually still being selected, as confirmed by our log output. But there are cases where, visual feedback or no, you do not want the row to be selected. Maybe you have other buttons and switches in the row and don't want them confused with a row tap, or maybe you will only being allowing taps on a small number of rows, and would like to weed out the others to simply code.

One thing about Apple's libraries is that the names of some methods can suggest the existence of other methods. In this case "didSelect" is telling you that it already happened. Although this is not a hard and fast rule, very often when there is a "didSomething" method, there will also be a "willSomething" method. One for just before the event, the other for just after the event. And that is indeed the case here, as a there is a "willSelect" method that looks like this:

```objc
// Objective-C

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
```
```swift
// Swift

func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
```
Notice that the return value is an index path, and specifically in Swift it is an optional return value. The documentation has this to say:
>Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.

This means you could do a couple different things here. If the user taps on row 2 but you want to select row 5 instead, you could return an appropriate index path and that's exactly what would happen. But that's weird, so let's focus on the other case. If we want to completely disable selection for a row, we can return nil. Let's turn them all off first, then talk a little about how to make it more useful:

```objc
// Objective-C

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
```
```swift
// Swift

func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
{
    return nil
}
```
If you run the app now, you might think that nothing has changed. You still see a gray highlight. However if you watch closely, you'll see that the highlight goes away much faster. But there are no logs in the console. What is happening here is that we are indeed blocking the selection of the row, but the selection highlight happens first. This comes from the selectionStyle value we saw before. Uncomment that line, then try again. This time there should be no row highlight, AND no logs in the console. So we've completely turned off row taps now.

This may not be the most useful situation for an average table view, so let's make it a little smarter. First of all, comment the selectionStyle line again. We'll handle that differently.

Let's imagine that we sell paint. But we're out of one of our colors, say green. So we want to make the table prevent selection of the green color. 

>Note: this is just for illustration of the concept of limiting row selection. In reality we would make this decision based on quantity or some other factor that we don't have here. It would be something we could inspect at runtime, rather than hard-code here. Bear with me.

We can add some logic to willSelectRow to identify when we're about to tap the green row, and disable it if so. That could look like this:

```objc
// Objective-C

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    if ([rowValue isEqualToString:@"Green"])
    {
        return nil;
    }
    
    return indexPath;
}
```
```swift
// Swift

func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
{
    let rowValue = contents[indexPath.row];
    
    if rowValue == "Green"
    {
        return nil
    }
    
    return indexPath
}
```
We look at the row contents, and if it is the green row we return nil. Otherwise, we return the same index path that came in. Run the app and observe that tapping on most rows behaves normally. Tapping on the green row does the quick highlight thing we just saw, and produces no log output.

Let's kill the quick highlight by using the selectionStyle property in cellForRow, but keep in mind everything we've learned with cell recycling. If we turn OFF the highlight for this row, we must turn it back ON for all of the other rows. Like so:

```objc
// Objective-C

...
   NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
   
   [[cell textLabel] setText:rowValue];
   
   if ([rowValue isEqualToString:@"Green"])
   {
       [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
   }
   else
   {
       [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
   }
    
   return cell;
}
```
```swift
// Swift

...
   let rowValue = contents[indexPath.row];
    
   cell.textLabel?.text = rowValue
    
   if rowValue == "Green"
   {
       cell.selectionStyle = .None
   }
   else
   {
       cell.selectionStyle = .Default
   }
    
   return cell
}
```
Run the app once more. On most rows, we get a normal highlight, normal deselect, and a log. On the green row, we get nothing. We see no highlight, we see no log.

Let's recap what we've seen so far:
* Tapping a row stays highlighted
* Tapping a row deselects
* Tapping a row prints a log
* Tapping a row does nothing

The specific combination of these behaviors will depend on your needs for any given table view.

For the most part, we've focused on what happens before or after you select a row. But you can also be informed of the same thing before or after you DEselect a row. There are plenty of occasions to need to know when deselection happens also. For example, in your average Twitter app, tapping on a row probably shows more information. Maybe reveals a few buttons, perhaps slides open a drawer of options, etc. Then when you tap a different row, the row you were just on reverts back to normal. You need to know when the row is no longer active so that you can restore that default state. This is accomplished with another pair of delegate methods that look an awful lot like the ones we've already seen. But I assure you they are different, and this is worth remembering because at some point in the future you will grab the wrong one.

First, comment out the deselection line:

```objc
// Objective-C

//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
```
```swift
// Swift

//    tableView.deselectRowAtIndexPath(indexPath, animated: true)
```

Then add these to your file:

```objc
// Objective-C

- (NSIndexPath *)tableView:(UITableView *)tableView
willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    NSLog(@"Will DE-select: %@", rowValue);
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    NSLog(@"Did DE-select: %@", rowValue);
}
```
```swift
// Swift

func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath?
{
    let rowValue = contents[indexPath.row];
    
    print("Will DE-select: \(rowValue)")
    
    return indexPath
}

func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath)
{
    let rowValue = contents[indexPath.row];
    
    print("Did DE-select: \(rowValue)")
}
```

Run the app and watch the logs. You'll see your primary row tap log, and that row will remain highlighted since we removed the deselect command. Then select another row. You will see logs informing you of the deselection of the first row, and then your selection log for the next row.

The difference between this set of methods and the first set is just 2 letters: "De". And I can assure you from personal experience that grabbing the wrong one will cause lots of hair pulling and teeth gnashing. So I will simply offer you this advice: Verify the difference between the "Select" methods and the "Deselect" methods before spending hours wondering why your table view is broken.

Before we end the chapter, let's circle back around to one topic that we glossed over at the time. In the [UITableViewCell Styles & Accessories](../06.UITableViewCell/UITableViewCell.md) chapter, we talked about cell accessories, like checkmarks. And we mentioned a couple different accessories that had "Button" in the name, and mentioned that they add a second tap zone to a row when used. Let's see how that works.

First, let's add our accessory to all rows, using the newer button option. We'll do this in cellForRow:

```objc
// Objective-C

if (cell == nil)
{
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    [cell setAccessoryType:UITableViewCellAccessoryDetailButton];
}
```
```swift
// Swift

if (optionalCell == nil)
{
    optionalCell = UITableViewCell.init(style: .Default, reuseIdentifier: identifier)
    optionalCell?.accessoryType = .DetailButton
}
```
If you run the app now, you'll see this accessory. But tapping on it doesn't do anything. We don't even see the row highlight or see our log. So this is a completely new tap target, and now we need to handle that tap. This is accomplished with yet another delegate method. Add this to your file:

```objc
// Objective-C

- (void)tableView:(UITableView *)tableView
accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowValue = [[self contents] objectAtIndex:[indexPath row]];
    
    NSLog(@"Accessory tap: %@", rowValue);
}
```
```swift
// Swift

func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath)
{
    let rowValue = contents[indexPath.row];
    
    print("Accessory tap: \(rowValue)")
}
```
Run the app, and tapping on the accessory will show our alternate log in the console. The one thing to notice is that we _can_ tap on the accessory for the green row. Even though we have disabled the primary row tap, the secondary one is still available. They are independent. Apple doesn't provide any methods to prevent tapping on accessories. You would either need to remove the accessory from certain rows, or simply perform no action upon tap. Removing it is probably a more appropriate user experience.

We have now seen a total of 5 UITableViewDelegate methods, and we still have a long ways to go. With these methods, your row can have anywhere from 0 to 2 tap targets, and you can even find out when your row is no longer selected. As an exercise find some random apps with table views, and decide which of these methods are being used.

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick