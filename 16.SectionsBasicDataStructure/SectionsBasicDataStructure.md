< [Section Headers and Footers](../15.SectionHeadersFooters/SectionHeadersFooters.md) | >

# Multiple Sections: Basic Data Structure

We've already done a [Basic Data Structure](../08.BasicDataStructure/BasicDataStructure.md) chapter, so you may be curious why we're seeing another one. Put simply, dealing with multiple sections adds a fair amount of complexity to your code, with a wide variety of ways to do things well, and probably a wider variety of ways to do things poorly. As in the first chapter, we will first look at bad ways of doing this, and then talk about how to establish a good foundation. Because there are so many ways to work with sections, additional techniques will be found in later chapters.

The basic task we will be tackling in this chapter is to make a simplified grocery list. We will have a collection of fruits, vegetables, and sweets, and we'll want to group those together. Like so:
>Fruits: Apple, Banana, Grape
Vegetables: Carrot, Celery
Sweets: Chocolate

3, 2, 1. Different kinds of items, different amounts of each time. Let's begin.

## Setup

Create a new iOS project, using the Single View Application template. Name it anything you want, like SectionsStructure. Choose your preferred language, device doesn't really matter but let's go with iPhone, and you can turn off any of the other checkboxes like Core Data as they will not be used in this chapter. Using your preferred technique, configure the provided view controller for table view use.

## The Bad Way

Instead of providing all of the initial code at once, let's build this one as we go.


< [Section Headers and Footers](../15.SectionHeadersFooters/SectionHeadersFooters.md) | >

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
If you found this guide to be helpful, a [tip](http://bit.ly/AW4Cc) would be appreciated.