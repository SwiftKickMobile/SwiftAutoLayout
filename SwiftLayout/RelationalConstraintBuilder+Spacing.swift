//
//  RelationalConstraintBuilder+Spacing.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation

public extension RelationalConstraintBuilder {
    
    /**
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func centerX(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.centerXAnchorInfo, second: secondConstrainable.centerXAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func centerY(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.centerYAnchorInfo, second: secondConstrainable.centerYAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func centerXY(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        centerX(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        centerY(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
}
