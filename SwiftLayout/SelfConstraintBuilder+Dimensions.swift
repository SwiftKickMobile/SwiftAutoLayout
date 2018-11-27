//
//  SelfConstraintBuilder+Dimensions.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import UIKit

public extension SelfConstraintBuilder {
    
    /**
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func width(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        constraints.append(makeDimensionConstraint(anchor: constrainable.widthAnchor, relation: relation, constant: constant, priority: priority, activate: activate))
        return self
    }
    
    /**
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func height(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        constraints.append(makeDimensionConstraint(anchor: constrainable.heightAnchor, relation: relation, constant: constant, priority: priority, activate: activate))
        return self
    }
    
    /**
     Specifies both width and height constraints to have the same constant. This method creates two constraints.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        width(relation, constant: constant, priority: priority, activate: activate)
        height(relation, constant: constant, priority: priority, activate: activate)
        return self
    }
    
    /**
     Specifies both width and height constraints to have a CGSize's width and height constants respectivly. This method creates two constraints.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal, size: CGSize = .zero, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        width(relation, constant: size.width, priority: priority, activate: activate)
        height(relation, constant: size.height, priority: priority, activate: activate)
        return self
    }
    
    /**
     Shorthand for constraining a height anchor to a width anchor with an apsect ratio multiplier
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func aspectRatio(_ aspectRatio: CGFloat, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        let constraint = constrainable.heightAnchor.constraint(equalTo: constrainable.widthAnchor, multiplier: aspectRatio)
        constraint.priority = priority
        if activate {
            constraint.isActive = true
        }
        constraints.append(constraint)
        return self
    }
}
