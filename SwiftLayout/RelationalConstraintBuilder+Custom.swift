//
//  RelationalConstraintBuilder+Custom.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 11/27/18.
//  Copyright © 2018 it.swiftkick. All rights reserved.
//

import Foundation

public extension RelationalConstraintBuilder {
    
    /**
     Method for building custom constraints between two different NSLayoutXAnchor anchors.
     If you want to constrain the same anchors across two constrainables, just use their named method. IE, `view.constrain(to: otherView).leading()`
     
     - Parameters:
         - firstAnchor: This constrainable's NSLayoutXAnchor that will be constrained to the other constrainable's anchor.
         - secondAnchor: The other constrainable's NSLayoutXAnchor that will be constrained to our constrainable's anchor
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     
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
    @discardableResult
    func xAxis(_ firstAnchor: XAxisAnchor, to secondAnchor: XAxisAnchor, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.anchorInfo(xAxis: firstAnchor), second: secondConstrainable.anchorInfo(xAxis: secondAnchor), relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     Method for building custom constraints between two different NSLayoutYAnchor anchors.
     If you want to constrain the same anchors across two constrainables, just use their named method. IE, `view.constrain(to: otherView).top()`
     
     - Parameters:
         - firstAnchor: This constrainable's NSLayoutYAnchor that will be constrained to the other constrainable's anchor.
         - secondAnchor: The other constrainable's NSLayoutYAnchor that will be constrained to our constrainable's anchor
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     
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
    @discardableResult
    func yAxis(_ firstAnchor: YAxisAnchor, to secondAnchor: YAxisAnchor, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.anchorInfo(yAxis: firstAnchor), second: secondConstrainable.anchorInfo(yAxis: secondAnchor), relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     Method for building custom constraints between two different NSLayoutDimension anchors.
     If you want to constrain the same anchors across two constrainables, just use their named method. IE, `view.constrain(to: otherView).width()`
     
     - Parameters:
         - firstAnchor: This constrainable's NSLayoutDimension anchor that will be constrained to the other constrainable's anchor.
         - secondAnchor: The other constrainable's NSLayoutDimension anchor that will be constrained to our constrainable's anchor
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     
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
    @discardableResult
    func dimension(_ firstAnchor: DimensionAnchor, to secondAnchor: DimensionAnchor, relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.anchorInfo(dimension: firstAnchor), second: secondConstrainable.anchorInfo(dimension: secondAnchor), relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
}
