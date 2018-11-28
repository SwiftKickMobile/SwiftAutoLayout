# SwiftLayout

[![Twitter: @TimothyMoose](https://img.shields.io/badge/contact-@TimothyMoose-blue.svg?style=flat)](https://twitter.com/TimothyMoose)
[![Version](https://img.shields.io/cocoapods/v/SwiftMessages.svg?style=flat)](http://cocoadocs.org/docsets/SwiftMessages)
[![License](https://img.shields.io/cocoapods/l/SwiftMessages.svg?style=flat)](http://cocoadocs.org/docsets/SwiftMessages)
[![Platform](https://img.shields.io/cocoapods/p/SwiftMessages.svg?style=flat)](http://cocoadocs.org/docsets/SwiftMessages)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Overview

SwiftLayout helps you write AutoLayout constraints as simply as possible. Constrain `UIView` and `UILayoutGuide`s interchangeably with a familiar syntax named to match their native properties.

Here's why it exists *****************

### Constraining a view to a parent view

Start by thinking about which two views you want to affect. In this example, a label will be constrained to a `UIViewController`'s view.

```swift
// UIViewController subclass
override func viewDidLoad() {
   super.viewDidLoad()
   
   // create a label
   let label = UILabel()
   label.text = "SwiftLayout is neato!"
   
   // constrain its leading and centerY anchors to be equal to our view's respective anchors
   label.constrain(to: view).leading().centerY()
}
```

The `constrain(to:)` method performs a couple useful actions before any constraints are made. The view calling it will have its `translatesAutoResizingMasksIntoConstraints` disabled, and will become a child of the second view if it doesn't yet have a parent. This makes it easy to define your view hierarchy while building constraints at the same time.

### Customizing constraints

SwiftLayout has 3 main methods for creating constraint builders. 

- `constrain(to:)` returns a `RelationalConstraintBuilder` that is useful for embedding a view inside another and matching its anchors.

- `constrain(after:)` returns a `DistributiveConstraintBuilder` that only has a couple methods for placing this view vertically or horizontally after another.

- `constrainSelf()` returns a `SelfConstraintBuilder` which is great for constraining your view's width, height, or aspect ratio.

```swift
// You can always grab the created constraints in the order they were created by accessing its `constraints` property.
let builder = label.constrain(to: view).leading().centerY()
print(builder.constraints.last!) // NSLayoutConstraint between centerY anchors

// alternatively...
let constraint = label.constrain(to: view).centerY(constant: 0).constraints.last!

// use the constraint later as needed   
constraint.constant = 100
```

There are also shorthand methods for making constraints in common combinations like `leadingTrailing()`, `topBottom()`, `centerXY()` and `leadingTrailingTopBottom()`.

### Advanced

For example,

## Installation

### CocoaPods

Add the following line to your Podfile:

````ruby
pod 'SwiftLayout'
````

### Carthage

Add the following line to your Cartfile:

````ruby
github "SwiftKickMobile/SwiftLayout"
````

### Manual

1. Put SwiftLayout repo somewhere in your project directory.
1. In Xcode, add `SwiftLayout.xcodeproj` to your project.
1. On your app's target, add the SwiftLayout framework:
   1. as an embedded binary on the General tab.
   1. as a target dependency on the Build Phases tab.

## Usage

### Basics

## About SwiftKick Mobile
We build high quality apps! [Get in touch](http://www.swiftkickmobile.com) if you need help with a project.

## License

SwiftMessages is distributed under the MIT license. [See LICENSE](./LICENSE.md) for details.
