//
//  DistributiveConstraintBuilder.swift
//  SwiftAutoLayout
//
//  Created by Jake Sawyer on 11/13/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

// Look at all this code you didn't have to write!

import Foundation
import UIKit

/**
 A constraint builder for laying out a `Constrainable` horizontally or vertically after another.
 */
public class DistributiveConstraintBuilder: ConstraintBuilder {
    
    /// The constraints created by this builder, in the order they were made.
    public internal(set) var constraints = [NSLayoutConstraint]()
    
    let beforeConstrainable: Constrainable
    let afterConstrainable: Constrainable
    
    /**
     Supplied constrainables, if they are `UIView`s, will have their `translatesAutoresizingMaskIntoConstraints` set to false.
     */
    init(before beforeConstrainable: Constrainable, after afterConstrainable: Constrainable) {
        self.beforeConstrainable = beforeConstrainable
        self.afterConstrainable = afterConstrainable
        
        for view in [beforeConstrainable, afterConstrainable].compactMap({ $0 as? UIView }) {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

// MARK: - Make Constraints
public extension DistributiveConstraintBuilder {
    /**
     Horizontally distribute the before and after constrainables via their leading and trailing anchors.
     - NOTE: Creates a single constraint.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func leadingTrailing(_ relation: NSLayoutConstraint.Relation = .equal,
                         constant: CGFloat = 0,
                         multiplier: CGFloat = 1,
                         priority: UILayoutPriority = .required,
                         activate: Bool = true) -> DistributiveConstraintBuilder {
        
        let constraint = makeConstraint(first: beforeConstrainable.trailingAnchorInfo,
                                        second: afterConstrainable.leadingAnchorInfo,
                                        relation: relation,
                                        constant: constant,
                                        multiplier: multiplier,
                                        priority: priority,
                                        activate: activate,
                                        inverse: true)

        constraints.append(constraint)
        return self
    }
    
    /**
     Vertically distribute the before and after constrainables via their top and bottom anchors.
     - NOTE: Creates a single constraint.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func topBottom(_ relation: NSLayoutConstraint.Relation = .equal,
                   constant: CGFloat = 0,
                   multiplier: CGFloat = 1,
                   priority: UILayoutPriority = .required,
                   activate: Bool = true) -> DistributiveConstraintBuilder {
        
        let constraint = makeConstraint(first: beforeConstrainable.bottomAnchorInfo,
                                        second: afterConstrainable.topAnchorInfo,
                                        relation: relation,
                                        constant: constant,
                                        multiplier: multiplier,
                                        priority: priority,
                                        activate: activate,
                                        inverse: true)
        
        constraints.append(constraint)
        return self
    }
    
}
