iOSCustomPageControllerDemoProject
==================================

![      ](\red.png "") ![      ](\green.png "") ![      ](\blue.png "")

##About 

><p> This page controller mimic's android style page controller, which we see in stock android's manage app option
><p> You can use this as and alternative to existing iOS page controller, or too keep UI consistency among android and iOS app

><p>This demo project has some basic code which you can use to create this type of page control 

## Basic idea behind this control

This controller need to scroll views 

1. Top scroll view - This will show titles of pages, for this UILabel's view are added to this.

2. Bottom scroll view - This will show actual content of pages, for this UIViewController's views are added to this. (You can add view's from same view controller, most common case is table view controller)


Swiping through pages

For this scrollview's delegate method is used

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView

If user swipes to left page in right is displayed as current page with swipe to left animation.
Page title is also animated with swipe effect along with page.


##Other Info : 


><li>Works for : iOS 6 and above</li>

><li>Uses ARC : Yes (Not much code you can easily convert to Non ARC if you want)</li>

><li>Xcode : 5 and above (Developed using 5.0.1)</li>

><li>Base SDK : 7.0 </li>

><li>Uses storybord/xib ? : Storyboard (But you can also create it with xib not much code just one View Controller is required)</li>


