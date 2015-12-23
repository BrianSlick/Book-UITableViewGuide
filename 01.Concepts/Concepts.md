# Concepts and Terminology

Table views are among the most commonly used UI widgets in iOS. From your email inbox to your Twitter feed, your contacts list to your settings, table views are used just about everywhere. If you are looking at a list - short or very very long - of even vaguely related items, chances are pretty good that you're looking at a UITableView.

Prior to iOS 6, the use of UITableView would almost be a certainty. In iOS 6, Apple introduced UICollectionView which borrows many of the same concepts, and can be made to look quite similar to a table view if you want to spend the effort. I do not currently intend to discuss UICollectionView as part of this series, but I will say that understanding how table views work will go a long way towards understanding how collection views work, so time spent here will not be wasted. If you are trying to decide which you need, then a basic guideline would be to use a table view for vertically scrolling content, and a collection view for horizontally scrolling content.

Let's start with the definition of UITableView, from the UIKit header files:

```objectivec
@interface UITableView : UIScrollView <NSCoding>
```
```swift
public class UITableView : UIScrollView, NSCoding
```


From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
