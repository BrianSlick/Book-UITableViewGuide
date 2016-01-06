# Setup With Storyboards

If you jumped straight here hoping that meant you could avoid doing some code, I have some bad news. This chapter builds off of the [Setup With Code]
(../02.SetupWithCode/SetupWithCode.md) chapter, so you do indeed need to read it first. That chapter establishes the basic minimum that you'll need to understand, and this chapter will only focus on what is changed by using a Storyboard instead of pure code. This chapter is not intended to train you on the use of Storyboards in general, so you will need to research elsewhere if the explanations here are inadequate.

Create a new iOS project, using the Single View Application template. Name it anything you want, like SetupWithStoryboards. Choose your preferred language, device doesn't really matter but let's stick with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter.

Storyboards (and IB) provide the means to do certain tasks graphically instead of in code. However, this is mostly just in the setup phase of objects. After the objects are created, the graphical capabilities don't do much for you anymore, so there will be a fair amount of table view work that will be the same - and done in code - regardless of how you started. We're going to make the exact same table that we made in the code chapter, and a fair amount of that code will be exactly the same, so let's go ahead and bring that over here to get a good start. Make your ViewController file look like this:

```objc
// Objective-C
// ViewController.m

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

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
    
    return  cell;
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
// ViewController.swift

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // MARK: - UITableViewDataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Default")
        
        cell.textLabel?.text = "Hello, World"
        
        return cell
    }
    
    // MARK: - UITableViewDelegate Methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        print("Tapped row \(indexPath.row)")
    }
}

```
I have removed the property, and much everything involved in creating the table view in viewDidLoad. (We still want a property, but we'll create it differently in this chapter). The implementation of the delegate methods remains the same, as does the protocol conformance declaration.

We'll return to this file in a moment, but let's take a look at the Storyboard.

![Blank storyboard](./images/storyboards_initial.png)

You see our blank view controller, and if you have the correct panel open on the right side, you can scroll through the list at the bottom and find the table view object. Grab one and drag it into the middle of the view controller. The size and position doesn't matter.

![Storyboard with a table view dragged in](./images/storyboards_drag_table.png)

We will again use Auto Layout to size and position the table view, but rather than use some ugly confusing code again, we can do it here in the Storyboard. In the screen shot above, down at the lower right there are 4 icons. Make sure the table view is selected, and then hit the second button from the right. It looks like a Star Wars TIE Fighter.

![Constraints panel](./images/storyboards_constraints.png)

Make your panel look like this one. This includes the following changes:
* Turn OFF "Constrain to margins"
* If the red lines are not a solid red as shown, click on them to turn them red.
* Make the value in each of the boxes at the top 0.
* Next to "Update Frames", select "Items of New Constraints" in the menu.

Finally, hit the "Add 4 Constraints" button. Once finished, the table view should fill the available space, and when selected you will see some blue lines around the perimeter.

Now we want to recreate the table view property that we did not carry over from the code chapter. We still want that property, but we're going to use the Storyboard to help us create it and establish a connection.

We want to be able to see our code file and our Storyboard file at the same time. There are several ways to get there. Look to the upper right of the Xcode window, and you will see these buttons:

![Constraints panel](./images/storyboards_primary_editor.png)

The group on the right is for toggling which of Xcode's panels are visible. We are interested in the group on the left. The first segment is blue, which indicates that we are in just a single view mode. Select the middle button, with the 2 circles:

![Constraints panel](./images/storyboards_assistant_editor.png)

This will open up a second panel, called the Assistant Editor, that shows the code file. It will either be to the side or underneath the Storyboard view depending on your settings.

If for some reason this didn't happen correctly, or if you just want to know a keyboard shortcut for accomplishing the same thing, you can hold down the Option key and select the ViewController file from the main list at the left. Option-clicking on any file will open it in the Assistant Editor.

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
