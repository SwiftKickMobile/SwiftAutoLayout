//
//  AnchorInfo.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 11/27/18.
//  Copyright © 2018 it.swiftkick. All rights reserved.
//

import UIKit

//MARK: - AnchorInfo

/**
 Internal helper struct for supplying all required attributes for creating a constraint in one simple package.
 As a bonus, you can look up an `AnchorInfo<T>` via `Constrainable.anchorInfo(xAxis/yAxis/dimension:)`
 */
struct AnchorInfo<AnchorType: AnyObject> {
    var item: Constrainable
    var attribute: NSLayoutConstraint.Attribute
    var anchor: NSLayoutAnchor<AnchorType>
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
    case leading, trailing, centerX
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
    case top, bottom, centerY
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
    case width, height
}
