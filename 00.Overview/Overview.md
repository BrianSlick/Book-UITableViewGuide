[Concepts and Terminology](../01.Concepts/Concepts.md) >

# Overview

There are a lot of UITableView tutorials out there. I've written several myself. So why do we need another one? Fair question. A lot of time has passed since I wrote my first set. Techniques and technologies have moved on, and I'm a much better coder with greater understanding today than I was at the time. Primarily I'm interested in updating my older material, expanding areas that I perhaps glossed over, and trying to shine a light on areas that don't get a lot of coverage otherwise. But at a fundamental level, I learn best by teaching, so I'd like to flex some new muscles by writing about techniques I don't use as often as others.

Why GitHub? Well, frankly, I'm not really expecting to make any money off of this anyway, regardless of publishing platform. But I would like to be a better community citizen and make an attempt to keep my code samples up to date. I feel that GitHub will allow that to be easier, or at least cleaner, than the set of blog posts that I have previously written. Also, the main thrusts of my various blogs has changed over time - I've even moved several tutorial posts from one blog to another because of this - and rather than try to justify or figure out what I'm putting whatever where, it makes sense to put tutorials alongside the code in a form that people are already familiar with.

My goal with this series is to cover UITableView in as broad a fashion as I can. The subjects involved may not be particularly advanced, per se, but I'm sure there are delegate methods out there that have never been written about, and that I've never used. I'd like to learn about them and write them.

My intention is to write code examples in both Objective-C and Swift. I feel that the majority of iOS developers will need to be able to speak both languages to some degree, so I'd like to support that effort. I am relatively new to Swift, as we all are of course but I skipped Swift 1, so this will help me to refine my own skills. Nothing attracts attention like mistakes on the Internet, so hopefully feedback will allow me to discover better techniques.

My personal biases: I am a fan of Interface Builder, I am not a fan of Storyboards, and I truly do not understand anyone that enjoys doing visual stuff in code. So anywhere that I have the choice between these approaches, I will use code if it helps to nail down a particular point, I will use IB because that is what I prefer, and I will use Storyboards because I acknowledge that many new folks only speak Storyboards. Table views also have some Storyboard-only features, so I can't really avoid that part if I wish to adequately cover the topic. And Xcode automatically creates Storyboards these days, so I can't really avoid them. Ideally this series will be written to adequately support all 3 approaches, but if you feel there is a pro-IB bias, you're not wrong and I won't apologize for it.

These tutorials will be originally authored using Xcode 7 and Swift 2, targeting iOS 9. I cannot make promises, but I will endeavor to keep code examples updated as Swift continues to evolve or as iOS continues to be revised. I will make no attempt to support Swift 1. For the most part, the Objective-C code and UITableView techniques in general have not really changed all that much over the years, so it is entirely possible that the contents here will work with several older versions of iOS. If they do, great, but I will not be making any special effort to support anything older than iOS 9, with a possible exception here and there that will be noted as special cases.

I will cover some basics as necessary, but fundamentally this series is about how to use and work with UITableView. This series will make no attempt to be your first exposure to:
* iOS Development in general
* Objective-C or Swift in particular
* Interface Builder, or Storyboards, or working without either one
* Auto Layout
* Core Data
* Any other ancillary techniques that I add later that wind up being inadequately explained

Feel free to bring to my attention whenever I explain something poorly, but if the subject matter is not specific to UITableView, I will most likely direct you to more authoritative sources on those matters.

Each chapter is placed into a separate directory in the repository. In addition to the main text, when applicable there will also be a "Sample Code" folder. I will make a Swift version and an Objective-C version whenever samples are needed. Unless otherwise noted, these will be completed projects, and I will not normally provide starter projects. Each chapter will have the instructions and required code in the main text to get started.

I absolutely encourage feedback. I'm not going to write the whole thing in private and then publish once it is all done. I will publish as I go. The main README will contain a table of contents. As I write sections, I will link them up. The remainder will serve as an indication of where I want to go, and the likely order that I'll write them in. I'm happy to consider requests for additional subject matters that aren't listed. The best way to reach me is [@BrianSlick](http://twitter.com/BrianSlick) on Twitter, or email brianslick -at- mac -dot- com.

[Concepts and Terminology](../01.Concepts/Concepts.md) >

---
From:
[A Reasonably Complete Guide to UITableView](https://github.com/BriTerIdeas/Book-UITableViewGuide), by Brian Slick
If you found this guide to be helpful, a [tip](http://bit.ly/AW4Cc) would be appreciated.
