//
//  Constrainable.swift
//  SwiftAutoLayout
//
//  Created by Jake Sawyer on 8/30/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import UIKit

/**
 Definition of a constrainable instance (usually a `UIView` or `UILayoutGuide`) and its anchors.
 ```
 // add constraints to a view with vertical padding
 view.constrain(to: otherView).leadingTrailing().topBottom(.lessThanOrEqual, constant: 8)
 ```
 - NOTE: This protocol does not include `baseline` anchors.
 */
public protocol Constrainable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

// MARK: - Declare UIView and UILayoutGuide to be constrainable
extension UIView: Constrainable {}
extension UILayoutGuide: Constrainable {}

// MARK: - Constraint Builders
public extension Constrainable {
    /**
     This method performs initial setup for constraining two `Constrainable`s together.
     In general, `UIView`s will have their autoresizing masks disabled, and will become children of the other `UIView` if they don't have one yet. Unowned `UILayoutGuide`s will have their owning views set.
     
     # Setup process:
     - If this is a `UIView`, its `translatesAutoresizingMaskIntoConstraints` will be disabled.
     - If this is a `UIView` and doesn't yet have a superview, and the supplied constrainable is also a `UIView`, this view will become a child of the supplied view.
     - If this is a `UIView` and doesn't yet have a superview, and the supplied constrainable is a `UILayoutGuide` with an owning view, this view will become the child of the supplied layout guide's owning view.
     - If this is a `UILayoutGuide` and doesn't yet have an owning view, and the supplied constrainable is a `UIView`, this layout guide will be added to the supplied view.
     - If this is a `UILayoutGuide` and doesn't yet have an owning view, and the supplied constrainable is also a `UILayoutGuide` with an owning view, this layout guide will add itself to the supplied layout guide's owning view.
     
     # Basic usage:
     ```
     // Constrain both leading anchors for `view` and `otherView` with an equal relationship, constant of 0, multiplier of 1, and required priority.
     // The constraint is activated by default.
     view.constrain(to: otherView).leading()
     
     // Constraint methods make heavy use of default arguments. You only need to specify arguments when setting specific values.
     view.constrain(to: otherView).width(.lessThanOrEqual, priority: .defaultLow)
     
     // Some constraints invert their anchors so your constants can always be positive. This includes trailing and bottom constraints.
     // In this example, `view` is inset inside `otherView` by 8 points from the top and 24 points from the bottom.
     view.constrain(to: otherView).top(constant: 8).bottom(constant: 24)
     
     // Chain method calls to create multiple constraints easily.
     view.constrain(to: otherView).top().bottom().width()
     ```
     
     # Advanced usage:
     ```
     // Helper methods simplify common scenarios by defining multiple constraints at the same time.
     view.constrain(to: otherView).centerXY().widthHeight()
     
     // Constrain a `view` to the `layoutMarginsGuide` of `otherView`, thus padding its edges inset from the safe areas and margins.
     view.constrain(to: otherView.layoutMarginsGuide).leadingTrailingTopBottom(constant: 32)
     
     // Access the constraint builder once the constraints are made, and grab the constraints
     let builder = view.constrain(to: otherView).leadingTrailing(constant: 16).topBottom(constant: 8)
     print(builder.constraints) // constraints are supplied in order of declaration. In this case: leading, trailing, top, bottom.
     
     // Create a highly customized constraint using system spacing, without activating it, and hold onto it for later use.
     let constraint = view.constrain(to: otherView).leading(.lessThanOrEqual, constant: .systemSpacing, multiplier: 0.5, priority: .defaultLow, activate: false).constraints.last!
     ```
     */
    @discardableResult
    func constrain(to constrainable: Constrainable) -> RelationalConstraintBuilder {
        return RelationalConstraintBuilder(first: self, second: constrainable)
    }
    
    /**
     This method performs initial setup for distributing two `Constrainable`s vertically and/or horizontally via constraints.
     `UIView`s will have their autoresizing masks disabled and are assumed to already have superviews.
     `UILayoutGuide`s are assumed to already have owning views.
     
     # Basic usage:
     ```
     // Constrain `view` horizontally after `otherView` via `otherView.trailingAnchor` and `view.leadingAnchor`.
     view.constrain(after: otherView).leadingTrailing()
     ```
     */
    func constrain(after constrainable: Constrainable) -> DistributiveConstraintBuilder {
        return DistributiveConstraintBuilder(before: constrainable, after: self)
    }
    
    /**
     This method performs initial setup for constraining a `Constrainable`'s width/height/aspect ratio.
     `UIView`s will have their autoresizing masks disabled.
     
     - NOTE: `CGFloat.systemSpacing` is not an acceptable constant here.
     
     # Basic usage:
     ```
     // Constrain `view`'s width to 50 points
     view.constrainSelf().width(constant: 50)
     
     // Constrain `view`'s width and height anchors to their intrinsic size at this moment
     view.constrainSelf().widthHeight(size: view.intrinsicContentSize)
     ```
     */
    func constrainSelf() -> SelfConstraintBuilder {
        return SelfConstraintBuilder(for: self)
    }
}

//MARK: - AnchorInfo

/**
 Internal helper struct for supplying all required attributes for creating a constraint in one simple package.
 As a bonus, you can look up an `AnchorInfo<T>` via `Constraiable.anchorInfo(xAxis/yAxis/dimension:)`
 */
struct AnchorInfo<AnchorType: AnyObject> {
    var item: Constrainable
    var attribute: NSLayoutConstraint.Attribute
    var anchor: NSLayoutAnchor<AnchorType>
}


// MARK: - Anchor Infos on Constrainable
extension Constrainable {
    var leadingAnchorInfo: AnchorInfo<NSLayoutXAxisAnchor> {
        return AnchorInfo(item: self, attribute: .leading, anchor: self.leadingAnchor)
    }
    
    var trailingAnchorInfo: AnchorInfo<NSLayoutXAxisAnchor> {
        return AnchorInfo(item: self, attribute: .trailing, anchor: self.trailingAnchor)
    }
    
    var topAnchorInfo: AnchorInfo<NSLayoutYAxisAnchor> {
        return AnchorInfo(item: self, attribute: .top, anchor: self.topAnchor)
    }
    
    var bottomAnchorInfo: AnchorInfo<NSLayoutYAxisAnchor> {
        return AnchorInfo(item: self, attribute: .bottom, anchor: self.bottomAnchor)
    }
    
    var widthAnchorInfo: AnchorInfo<NSLayoutDimension> {
        return AnchorInfo(item: self, attribute: .width, anchor: self.widthAnchor)
    }
    
    var heightAnchorInfo: AnchorInfo<NSLayoutDimension> {
        return AnchorInfo(item: self, attribute: .height, anchor: self.heightAnchor)
    }
    
    var centerXAnchorInfo: AnchorInfo<NSLayoutXAxisAnchor> {
        return AnchorInfo(item: self, attribute: .centerX, anchor: self.centerXAnchor)
    }
    
    var centerYAnchorInfo: AnchorInfo<NSLayoutYAxisAnchor> {
        return AnchorInfo(item: self, attribute: .centerY, anchor: self.centerYAnchor)
    }
}

// MARK: - Anchor Types

/**
 Helper for writing custom constraints between two different `NSLayoutXAxisAnchor` anchors.
 
 ```
 // Constrain view's centerX anchor to another view's leading anchor
 view.constrain(to: otherView).xAxis(.centerX, to: .leading)
 
 // Modify the optional arguments to specify a more advanced constraint
 view.constrain(to: otherView).xAxis(.centerX, to: .leading, relation: .lessThanOrEqual, constant: 0, multiplier: 0.5, activate: false)
 
 // Use the constraint builder returned after each newly created constraint to access the constraints created in order
 let constraint = view.constrain(to: otherView).xAxis(.centerX, to: .leading, constant: 0, priority: .defaultHigh, activate: false).constraints.last!
 constraint.isActive = true // activate the constraint later
 ```
 */
public enum XAxisAnchor {
    case leading
    case trailing
    case centerX
}

/**
 Helper for writing custom constraints between two different `NSLayoutYAxisAnchor` anchors.
 
 ```
 // Constrain view's centerY anchor to another view's bottom anchor
 view.constrain(to: otherView).yAxis(.centerY, to: .bottom)
 
 // Modify the optional arguments to specify a more advanced constraint
 view.constrain(to: otherView).yAxis(.centerY, to: .bottom, relation: .lessThanOrEqual, constant: 0, multiplier: 0.5, activate: false)
 
 // Use the constraint builder returned after each newly created constraint to access the constraints created in order
 let constraint = view.constrain(to: otherView).yAxis(.centerY, to: .bottom, constant: 0, priority: .defaultHigh, activate: false).constraints.last!
 constraint.isActive = true // activate the constraint later
 ```
 */
public enum YAxisAnchor {
    case top
    case bottom
    case centerY
}

/**
 Helper for writing custom constraints between two different `NSLayoutDimension` anchors.
 
 ```
 // Constrain view's width anchor to another view's height anchor
 view.constrain(to: otherView).dimension(.width, to: .height)
 
 // Modify the optional arguments to specify a more advanced constraint
 view.constrain(to: otherView).dimension(.width, to: .height, relation: .lessThanOrEqual, constant: 0, multiplier: 0.5, activate: false)
 
 // Use the constraint builder returned after each newly created constraint to access the constraints created in order
 let constraint = view.constrain(to: otherView).dimension(.width, to: .height, constant: 0, priority: .defaultHigh, activate: false).constraints.last!
 constraint.isActive = true // activate the constraint later
 ```
 */
public enum DimensionAnchor {
    case width
    case height
}


// MARK: - Getting AnchorInfos from enums
extension Constrainable {
    func anchorInfo(xAxis anchorType: XAxisAnchor) -> AnchorInfo<NSLayoutXAxisAnchor> {
        switch anchorType {
        case .leading: return leadingAnchorInfo
        case .trailing: return trailingAnchorInfo
        case .centerX: return centerXAnchorInfo
        }
    }
    
    func anchorInfo(yAxis anchorType: YAxisAnchor) -> AnchorInfo<NSLayoutYAxisAnchor> {
        switch anchorType {
        case .top: return topAnchorInfo
        case .bottom: return bottomAnchorInfo
        case .centerY: return centerYAnchorInfo
        }
    }
    
    func anchorInfo(dimension anchorType: DimensionAnchor) -> AnchorInfo<NSLayoutDimension> {
        switch anchorType {
        case .width: return widthAnchorInfo
        case .height: return heightAnchorInfo
        }
    }
}
