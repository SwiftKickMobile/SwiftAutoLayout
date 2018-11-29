# SwiftAutoLayout

[![Twitter: @TimothyMoose](https://img.shields.io/badge/contact-@TimothyMoose-blue.svg?style=flat)](https://twitter.com/TimothyMoose)
[![Version](https://img.shields.io/cocoapods/v/SwiftAutoLayout.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAutoLayout)
[![License](https://img.shields.io/cocoapods/l/SwiftAutoLayout.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAutoLayout)
[![Platform](https://img.shields.io/cocoapods/p/SwiftAutoLayout.svg?style=flat)](http://cocoadocs.org/docsets/SwiftAutoLayout)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

<p align="center">
  <img src="./Design/SwiftAutoLayoutBanner.gif" />
</p>

## Overview

SwiftAutoLayout helps you write AutoLayout constraints as consisely, Swiftly, and as natively as possible. Constrain `UIView` and `UILayoutGuide`s interchangeably with a familiar syntax named to match their native properties. This library purposefuly minimizes the repetitive code of defining view hierarchies and building constraints while maximizing constraint flexibility via optional parameters.

SwiftAutoLayout is written to match the AutoLayout APIs as closely as possible, only wrapping types where it improves legibility and simplifies amount of written code. This means your knowledge of AutoLayout directly translates to SwiftAutoLayout, with minimal functionality introduced on top. SwiftAutoLayout does not provide any custom closures or syntaxes for defining constraints, and prefers a functional proramming angle to keep things on a minimum number of lines.

## Usage

### Constraining a View to a Parent View

Start by thinking about which two views you want to affect. In this example, a label will be constrained to a `UIViewController`'s view and added to its hierarchy.

```swift
// UIViewController subclass
override func viewDidLoad() {
   super.viewDidLoad()
   
   // Create a label
   let label = UILabel()
   label.text = "SwiftAutoLayout is neato!"
   
   // Constrain its leading and centerY anchors to be equal to our view's respective anchors
   // Because label doesn't yet have a parent, it will become a child of our view
   label.constrain(to: view).leading().centerY()
}
```

That's it! The label is now in the hierarchy and constrained correctly.

### Building the View Hierarchy

The `constrain(to:)` method performs a couple useful actions before any constraints are made. The view calling it will have its `translatesAutoResizingMasksIntoConstraints` disabled, and will become a child of the second view if it doesn't yet have a parent. This makes it easy to define your view hierarchy while building constraints at the same time.

```swift
// Wrap a label in a container view that has a grey background and some internal padding.
let container = UIView()
container.backgroundColor = .gray
container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
container.constrain(to: view).centerXY()

// Constrain a label to the layout margins guide of the container. This means we
// get padding for free! No need to define constants in these constraints.
// Label will become a child of the layout guide's owning view.
let label = UILabel()
label.constrain(to: container.layoutMarginsGuide).leadingTrailingTopBottom()

// Ensure the label doesn't get wider than our view within a constant. 
// Since label is a child of container by this point, SwiftAutoLayout doesn't set its parent.
label.constrain(to: view).width(.lessThanOrEqual, constant: -60, priority: .defaultHigh)

// The view hierarchy is now:
// view
//  └ container
//     └ label
```

### Customizing Constraints

SwiftAutoLayout makes use of optional arguments to provide clean code when the constraint criteria is an `.equal` relationship, has a constant of 0, multiplier of 1, priority of `.required` and should activate the constraint upon creation. To specify custom values, supply the appropriate method with an argument.

```swift
// Simple leading padding of 16 points
label.constrain(to: view).leading(constant: 16)

// Simple trailing padding of 16 points. 
// NOTE: Constraints between trailing and bottom anchors have their items reversed
// so your constants can always be positive when insetting!
label.constrain(to: view).trailing(constant: 16)

// Get as customized as you like!
label.constrain(to: view).top(.greaterThanOrEqual, constant: 8, multiplier: 0.5, priority: .defaultLow)

// In common scenarios where multiple constraints are defined together, 
// helper methods create multiple constraints using the supplied arguments
label.constrain(to: view).leadingTrailing(constant: 16).topBottom(constant: 8)

// As a bonus, this makes it super easy to pin a view to a container,
// become its child, and disable its resizing mask in a single line of code
label.constrain(to: view).leadingTrailingTopBottom()

// And as a bonus to that bonus, if you want the label to be constrained to
// the view's margins inset from the safe area, use its margins layout guide!
label.constrain(to: view.layoutMarginsGuide).leadingTrailingTopBottom()
```

### Defining Different Kinds of Constraints

SwiftAutoLayout has 3 main methods for creating different constraint builders suited for different tasks.

- `constrain(to:)` returns a [`RelationalConstraintBuilder`](./SwiftAutoLayout/RelationalConstraintBuilder.swift) that is useful for embedding a view inside another and creating constraints that match anchors. In uncommon scenarios where you want to define a constraint between two different anchors, use this builder's `xAxis(_:to:)`, `yAxis(_:to:)`, and `dimension(_:to:)` methods.

- `constrain(after:)` returns a [`DistributiveConstraintBuilder`](./SwiftAutoLayout/DistributiveConstraintBuilder.swift) that has a couple methods for placing this view vertically or horizontally after another. This builder expects its views and layout guides to already have parents.

- `constrainSelf()` returns a [`SelfConstraintBuilder`](./SwiftAutoLayout/SelfConstraintBuilder.swift) which is great for constraining your view's width, height, or aspect ratio.

### Getting Constraints

All three builders provide an array of their constraints in their created order.

```swift
// You can grab a reference to the builder itself...
let builder = label.constrain(to: view).leading().centerY()
print(builder.constraints.last!) // NSLayoutConstraint between centerY anchors

// ...or just access the array of constraints directly!
let constraint = label.constrain(to: view).centerY(constant: 0).constraints.last!

// Then use the constraint later as needed.
constraint.constant = 100

// Keep in mind some helper methods create multiple constraints in the order they're named.
// This should be clear based on method name, and their documentation will specify constraint count.
let constraints = label.constrain(to: view).leadingTrailingTopBottom().constraints
print(constraints.count) // 4

// You can put constraints on their own lines thanks to functional chanining. Here we 
// dynamically activate a constraint later, as such its priority must be lower than `.required`
let constraint = label.constrainSelf()
   .height(constant: 0, priority: .required - 1, activate: false)
   .constraints.last!
   
constraint.isActive = true // smoosh!
```

### System Spacing

You can specify constraints that use system spacing for their "constant" in iOS 11 and later. This is accomplished by an extension on `CGFloat` named `.systemSpacing` — which is a special placeholder value SwiftAutoLayout will take into account when creating your constraint. This value has no use outside of SwiftAutoLayout, and does not work with the `constrainSelf()` builder.

```swift
label.constrain(to: view).leadingTrailing(constant: .systemSpacing)
```

### Custom Constraints

In scenarios where you want to make a custom constraint between two different anchors, use the appropriate method after `constrain(to:)`. The need for specialized methods for `T` in `NSLayoutAnchor<T>` makes creating these custom constraints type-safe and more crash resistant.

```swift
// NSLayoutXAxisAnchor: Constrain label's centerXAnchor to view's leadingAnchor
label.constrain(to: view).xAxis(.centerX, to: .leading)

// NSLayoutYAxisAnchor: Constrain label's centerYAnchor to view's topAnchor
label.constrain(to: view).yAxis(.centerY, to: .top)

// NSLayoutDimension: Constrain label's widthAnchor to view's heightAnchor
label.constrain(to: view).dimension(.width, to: .height)
```

## Ideology

### Note about Left and Right Anchors

SwiftAutoLayout does not use left and right anchors. This simplifies x axis anchors usage by disallowing incorrect usage (mixing left and leading) and cleans up autocomplete. [Apple states](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html) you should use leading and trailing anchors always, and in scenarios where you want your constraints to not be affected by language direction, change your view's [`semanticContentAttribute`](https://developer.apple.com/documentation/uikit/uiview/1622461-semanticcontentattribute).

> Avoid using Left and Right attributes. Use Leading and Trailing instead. This allows the layout to adapt to the view’s reading direction. 

> By default the reading direction is determined based on the current language set by the user. However, you can override this where necessary. In iOS, set the [`semanticContentAttribute`](https://developer.apple.com/documentation/uikit/uiview/1622461-semanticcontentattribute) property on the view holding the constraint (the nearest common ancestor of all views affected by the constraint) to specify whether the content’s layout should be flipped when switching between left-to-right and right-to-left languages.

## Tips, Tricks, and Gotchas

### Custom Parents

If you have a special scenario where you want a view's parent to not be set when using `constrain(to:)`, just set its parent beforehand. SwiftAutoLayout's goal is to simplify hierarchy generation and ensure a view has a parent when constraints are created, and it will not change a hierarchy once it exists.

### Work from the Bottom Up

When defining your view hierarchy, it's best to start by defining and constraining the first views to become children of your root view and constraining children views after. In general, you want to use `constrain(to:)` before you use `constrain(after:)` since the latter expects both views/layout guides to have parents. `constrainSelf()` can be called at any time, the view doesn't need a parent for a self constraint.

### Define Constraints Consistently

It's easy to attempt to compartmentalize all your constraint code with your view setup code, but it is recommended to set up all of your constraints in a place where your root view has a parent. For view controllers, set up your constraints in `viewDidLoad()` or later, and avoid defining constraints in a `UIView` or `UIViewController` initializer.

### Debugging Constraint Issues

As a reminder, setting a view's [`accessibilityIdentifier`](https://developer.apple.com/documentation/uikit/uiaccessibilityidentification/1623132-accessibilityidentifier) to a concise string will help you identify problem views when constraint errors are printed.

### Use Layout Guides!

`UILayoutGuide`s are awesome. If you set up your views correctly and use their [`directionalLayoutMargins`](https://developer.apple.com/documentation/uikit/uiview/2865930-directionallayoutmargins) you can write elegant constraints with minimal constants. Since SwiftAutoLayout doesn't use left and right anchors, it's recommended to use [`NSDirectionalEdgeInsets`](https://developer.apple.com/documentation/uikit/nsdirectionaledgeinsets) when setting up your layout guides.

You can also create new layout guides instead of views when you need to simplify view layout.

```swift
// Create a layout guide that will determine a height in which some buttons
// will be spread out along the x axis, and centered on the y axis
let buttonsLayoutGuide = UILayoutGuide()
buttonsLayoutGuide.constrain(to: view.layoutMarginsGuide).leadingTrailing().bottom()
buttonsLayoutGuide.constrainSelf().height(constant: 60)

let buttons = [UIButton(), UIButton(), UIButton()]
buttons.forEach { $0.constrainSelf().widthHeight(constant: 40) }
zip(buttons, [0.5, 1.0, 1.5]) { (button, multiplier)
   button.constrain(to: buttonsLayoutGuide).centerX(multiplier: multiplier).centerY()
}
```

## Room for Improvement

As of now, SwiftAutoLayout does not support AppKit, but is open to pull requests!

SwiftAutoLayout only supports anchors that both `UIView` and `UILayoutGuide` have, so `firstBaselineAnchor` and `lastBaselineAnchor` (which only exist on `UIView`) are not yet supported. Again, pull requests are welcome!

## Installation

### CocoaPods

Add the following line to your Podfile:

````ruby
pod 'SwiftAutoLayout'
````

### Carthage

Add the following line to your Cartfile:

````ruby
github "SwiftKickMobile/SwiftAutoLayout"
````

### Manual

1. Put SwiftAutoLayout repo somewhere in your project directory.
1. In Xcode, add `SwiftAutoLayout.xcodeproj` to your project.
1. On your app's target, add the SwiftAutoLayout framework:
   1. as an embedded binary on the General tab.
   1. as a target dependency on the Build Phases tab.

## About SwiftKick Mobile
We build high quality apps! [Get in touch](http://www.swiftkickmobile.com) if you need help with a project.

## License

SwiftAutoLayout is distributed under the MIT license. [See LICENSE](./LICENSE.md) for details.
