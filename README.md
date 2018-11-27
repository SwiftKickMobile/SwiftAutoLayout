# SwiftLayout

[![Twitter: @TimothyMoose](https://img.shields.io/badge/contact-@TimothyMoose-blue.svg?style=flat)](https://twitter.com/TimothyMoose)
[![Version](https://img.shields.io/cocoapods/v/SwiftMessages.svg?style=flat)](http://cocoadocs.org/docsets/SwiftMessages)
[![License](https://img.shields.io/cocoapods/l/SwiftMessages.svg?style=flat)](http://cocoadocs.org/docsets/SwiftMessages)
[![Platform](https://img.shields.io/cocoapods/p/SwiftMessages.svg?style=flat)](http://cocoadocs.org/docsets/SwiftMessages)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Overview

SwiftLayout helps you write AutoLayout constraints as simply as possible. Constrain `UIView` and `UILayoutGuide`s interchangeably with a familiar syntax named to match their native properties.

### How it works

Start by thinking about which two views and/or layout guides you want to affect. For starters, it's easy to create a label and constrain it to a view's anchors.
```swift
// UIViewController subclass
override func viewDidLoad() {
   super.viewDidLoad()
   
   // create a label and constrain its leading, trailing, and centerY anchors to our view
   let label = UILabel()
   label.constrain(to: view).leading().trailing().centerY()
}
```
Both `UIView` and `UILayoutGuide` have a `constrain(to:)` method for easily adding constraints between each other. This method handles initial setup by disabling `translatesAutoResizingMasksIntoConstraints` where needed and will make your first constrainable a child of the second if it doesn't yet have a `parentView` or `owningView`.

There are also shorthand methods for making constraints in common combinations like `leadingTrailing()`, `topBottom()`, `centerXY()` and `leadingTrailingTopBottom()`.

### Customizing constraints

It's also easy to customize constraints.

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
