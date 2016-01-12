< [Setup with Interface Builder](../04.SetupWithInterfaceBuilder/SetupWithInterfaceBuilder.md) | [UITableViewCell Styles & Accessories](../06.UITableViewCell/UITableViewCell.md) >

# UITableViewController

I didn't want to write this chapter. UITableViewController is one of the most commonly-used classes that I wish Apple had never written. Or perhaps, I wish they had implemented it differently. I was going to ignore it altogether, but I decided that I would be doing a disservice to the topic at large by leaving it out. And then I was just going to slide it in at the end and hope that nobody read it, but ultimately decided that it made sense to fit it along with the other methods of table view setup.

## Overview

First of all, what is UITableViewController? As the name suggests, it is a view **controller** class. So this should not be confused with UITableView itself. One is a view type, the other is a view controller type. It is ultimately provided by Apple for convenience, or so I'm sure that the authors thought at the time. And it has the distinction of being one of, if not THE, only specific subclasses of UIViewController that Apple provides that doesn't do something entirely unique. There is no UIScrollViewController class, there is no UITextViewController class, etc. There is a UIPageViewController class, but that does far more than simply serve as a view controller for a view type (there is no UIPageView). I can make any plain UIViewController do what UITableViewController does pretty easily (we've already done it 3 times), so in the grand scheme of things Apple should provide, this ranks pretty low. But here we are.

To see just what UITableViewController provides, we don't have to look much farther than the header file:

```objc
// Objective-C

//  UITableViewController.h

// Creates a table view with the correct dimensions and autoresizing, setting the datasource and delegate to self.

@interface UITableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
...
@property (nonatomic, strong) UITableView *tableView;
...
```
```swift
// Swift

//  UITableViewController.h

// Creates a table view with the correct dimensions and autoresizing, setting the datasource and delegate to self.

public class UITableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
...
public var tableView: UITableView!
...
```
There are several things to notice here. First, as previously stated, this is a view controller class, and we can see here that it does indeed inherit from UIViewController. Next, on that very same line of code, we see that this class conforms to UITableViewDelegate and UITableViewDataSource. Recall that we've been adding that manually previously, here it is built in. Also notice that there is a tableView property, just like we've been adding manually. Finally, if you read that comment all the way to the end, you'll see that the dataSource and delegate has been set to self, just like we've doing. So UITableViewController provides a UITableView that it manages by itself.

At first glance, here is a lot of stuff baked in already that we've been doing manually, so on the surface that would seem to be a good thing. So why do I dislike this class? Well, we'll get there towards the end of this chapter. But for now, I agree, less stuff to do manually is good.

## Setup

Let's go ahead and see this in action. We're going to repeat what we did in the [Interface Builder](../04.SetupWithInterfaceBuilder/SetupWithInterfaceBuilder.md) chapter and mostly ignore the Storyboard. So we will again add a button to the default view controller that presents our new view controller manually.

Create a new iOS project, using the Single View Application template. Name it anything you want, like TVC. Choose your preferred language, device doesn't really matter but let's stick with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter.

## View Controller Creation

Ctrl-click on the folder that contains the other source files, and choose "Add File..." from the menu. We will create a Cocoa Touch Class with the following characteristics:
* Class: CustomTableViewController
* Subclass of: UITableViewController
* Turn OFF checkbox creating a XIB file.
* Choose your preferred language.

And let's take a look at our new file. First off, notice that Apple includes LOTS of boilerplate code. It's up to you whether that is considered good or bad; I personally find that I don't use very much of the boilerplate that Apple includes so it's just that much more stuff I have to clear out. So strike one against this class for excessive boilerplate. But let's draw attention to one thing in particular here:

```objc
// Objective-C

#pragma mark - Table view data source
```
```swift
// Swift

// MARK: - Table view data source
```
Le sigh. I talked about this in the code chapter. On the one hand, it's good that they include this, to encourage people to be more organized with their code. On the other, this would be so much more useful if they just did this:
```objc
// Objective-C

#pragma mark - UITableViewDataSource Methods
```
```swift
// Swift

// MARK: - UITableViewDataSource Methods
```
Aaah, like warm clothes fresh from the dryer. Not only can you now quickly get to the documentation (at least in Objective-C) from these comments, but if you wish to search your project for these methods, you now have a reliable search term. No need to bother remembering if you used "table methods" or "table data methods" or just "data source" or any number of other possible combinations. Search for "UITableViewDataSource", boom, found, done.

Let's bring forth our repeated code from the earlier projects, now to be reused here for the 4th time. Make your file look like this:

```objc
// Objective-C

#import "CustomTableViewController.h"

@interface CustomTableViewController ()

@end

@implementation CustomTableViewController

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Default"];
    
    [[cell textLabel] setText:@"Hello, World"];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"Tapped row %ld", [indexPath row]);
}

@end
```
```swift
// Swift

import UIKit

class CustomTableViewController: UITableViewController
{
    // MARK: - UITableViewDataSource Methods
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Default")
        
        cell.textLabel?.text = "Hello, World"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print("Tapped row \(indexPath.row)")
    }
}

```
Believe it or not, we are actually done with this class. So notice what we don't have here: We don't have the protocol conformance flags, and we don't have the tableView property. We got those automatically by subclassing UITableViewController. The "override" keywords in the Swift code have to do with how Swift handles subclassing, a discussion beyond the scope of this article. Otherwise this is the same code we've dealt with so far.

All we need to do now is add a button to our storyboard. Refer to the [Interface Builder](../04.SetupWithInterfaceBuilder/SetupWithInterfaceBuilder.md) chapter if you need help. Drag a button into the view controller. Change the text to "Show My View Controller", then Ctrl-drag from the button into ViewController(.swift or .m) to create the action method. Make that action method look like this:

```objc
// Objective-C
// ViewController.m

#import "ViewController.h"
#import "CustomTableViewController.h"

...

- (IBAction)showButtonPressed:(id)sender
{
   CustomTableViewController *customTableViewController = [[CustomTableViewController alloc] initWithStyle:UITableViewStylePlain];
   
   [self presentViewController:customTableViewController animated:YES completion:nil];
}

```
```swift
// Swift
// ViewController.swift

@IBAction func showButtonPressed(sender: AnyObject)
{
   let customTableViewController = CustomTableViewController(style: .Plain)
   presentViewController(customTableViewController, animated: true, completion: nil)
}

```
Again note that the ObjC version must #import the view controller.

Go ahead and run the app, and you should see our familiar table view slide onto the screen after hitting the button on the screen.

## Considerations

Right about now you may be wondering why I don't like UITableViewController. Seems nice so far. It's the smallest amount of code we've had to deal with. I didn't have to do any of that fiddly setup in IB or the Storyboard. This is great! And if the _sole_ purpose of this view controller will forever be to _only_ show a table view and _nothing_ more, it _is_ great. And that might even be a reasonable assumption for your view controller today. But a lot of times those assumptions don't hold up.

Let's say there is something that you want to show on this screen. Maybe a button, maybe some kind of a status view or something. And you want for that item to remain in a fixed location on the screen. So as the user scrolls through the table view, the table should scroll behind this widget, so that the widget can remain stationary. Let's create a sample view to represent this widget. Add this viewDidLoad implementation to your CustomTableViewController file:

```objc
// Objective-C

// CustomTableViewController.m

- (void)viewDidLoad
{
   [super viewDidLoad];
    
   UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
   [subview setBackgroundColor:[UIColor redColor]];
   [[self view] addSubview:subview];
}
```
```swift
// Swift

// CustomTableViewController.swift

override func viewDidLoad()
{
   super.viewDidLoad()
        
   let subview = UIView.init(frame: CGRectMake(50, 50, 100, 100))
   subview.backgroundColor = UIColor.redColor()
   view.addSubview(subview)
}
```
Run the app, and you will see a red square in the upper left. So far, so good. Now scroll the table view, which admittedly won't scroll far with so few items, but it will scroll enough. Oh, it will scroll enough. Notice that the red square moves. But wait a second, the whole point of this was for that red box to stay put. Right you are, and we have now reached the reason I don't like this class. Incidentally, "my view is moving but I want it to stay put" was a very common question on developer boards in the early days. For all of the time "saved" by Apple in creating this class, that time was lost in equal or greater measure because of this behavior.

So what's happening here? Well, we can answer that by adding a couple of simple logs:

```objc
// Objective-C

// CustomTableViewController.m

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"%@", self.view);
    NSLog(@"%@", self.tableView);
    ...
```
```swift
// Swift

// CustomTableViewController.swift

override func viewDidLoad()
{
   super.viewDidLoad()
        
   print("\(view)")
   print("\(tableView)")
   ...
```
> UITableView: 0x7fdddd00e400; frame = (0 20; 320 548)...
UITableView: 0x7fdddd00e400; frame = (0 20; 320 548)...

I've clipped most of the text, but we really don't need to read past the object ID to see that these two properties are the same. In case the implication isn't clear, remember that the whole point of UIViewController is to manage a view. Specifically, self.view, which under normal circumstances doesn't move. The root view of each UIViewController is what we've been adding our table view to this entire time. We did it in code, and we did it IB. So our tableView was a **subview** of self.view. But not here; not in UITableViewController. Our tableView **IS** self.view.

Recall from the overview chapter that UITableView inherits from UIScrollView, and thus a table view is a scrollable view. Therefore, by default, any additional views that we add to any scroll view will scroll. By using UITableViewController, we have replaced our stationary, plain Jane UIView self.view with a scrollable UITableView. This means we no longer have a stationary view to use when we want to add stationary things that float about our table view. Anything we add to self.view will now scroll with table, because we actually added it to the table. There was nothing else to add it to. And if we want that view to stay put now, we have to implement UIScrollView delegate methods and adjust the position of that view each time the table scrolls. Bleh.

And the issue isn't only with items that should "float" over the table view. Maybe you want a stationary header or footer view that provides status information. Same issue, it will scroll, and you have to take additional steps to keep it in a fixed position. As I said, as long as you **only** want to show a table view, this situation is fine. But the moment you want to show anything else, which happens a fair amount, you will almost certainly regret starting with UITableViewController.

## Summary

So friends, don't let friends use UITableViewController.

< [Setup with Interface Builder](../04.SetupWithInterfaceBuilder/SetupWithInterfaceBuilder.md) | [UITableViewCell Styles & Accessories](../06.UITableViewCell/UITableViewCell.md) >


---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
If you found this guide to be helpful, a [tip](http://bit.ly/AW4Cc) would be appreciated.