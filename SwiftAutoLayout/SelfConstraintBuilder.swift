//
//  SelfConstraintBuilder.swift
//  SwiftAutoLayout
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

// Look at all this code you didn't have to write!

import Foundation

/**
 Creates constraints that are self-defining, like width, height, and aspect ratios.
 */
public class SelfConstraintBuilder: ConstraintBuilder {
    
    /// The constraints created by this builder, in the order they were made.
    public internal(set) var constraints = [NSLayoutConstraint]()
    
    let constrainable: Constrainable
    
    /**
     Views will have their `translatesAutoresizingMaskIntoConstraints` disabled.
     */
    init(for constrainable: Constrainable) {
        self.constrainable = constrainable
        if let view = constrainable as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    /// Helper method for defining self constraints instead of constraints between two `Constrainable`s.
    func makeDimensionConstraint(anchor: NSLayoutDimension,
                                 relation: NSLayoutConstraint.Relation,
                                 constant rawConstant: CGFloat,
                                 priority: UILayoutPriority,
                                 activate: Bool) -> NSLayoutConstraint {
        
        var constant = rawConstant
        if #available(iOS 11, *), constant == .systemSpacing {
            assertionFailure("[SwiftAutoLayout] Unsupported usage of `CGFloat.systemSpacing` with `SelfConstraintBuilder`!")
            constant = 8
            print("[SwiftAutoLayout] Using `\(constant)` as a placeholder value instead of `.systemSpacing` in `SelfConstraintBuilder`!")
        }
        let result: NSLayoutConstraint
        switch relation {
        case .equal:
            result = anchor.constraint(equalToConstant: constant)
        case .lessThanOrEqual:
            result = anchor.constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqual:
            result = anchor.constraint(greaterThanOrEqualToConstant: constant)
        }
        result.priority = priority
        if activate {
            result.isActive = true
        }
        return result
    }
}

// MARK: - Make Constraints
public extension SelfConstraintBuilder {
    /**
     Constrains width anchor to a constant.
     - NOTE: Creates a single constraint.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func width(_ relation: NSLayoutConstraint.Relation = .equal,
                      constant: CGFloat = 0,
                      priority: UILayoutPriority = .required,
                      activate: Bool = true) -> SelfConstraintBuilder {
        
        let constraint = makeDimensionConstraint(anchor: constrainable.widthAnchor,
                                                 relation: relation,
                                                 constant: constant,
                                                 priority: priority,
                                                 activate: activate)
        
        constraints.append(constraint)
        return self
    }
    
    /**
     Constrains height anchor to a constant.
     - NOTE: Creates a single constraint.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func height(_ relation: NSLayoutConstraint.Relation = .equal,
                       constant: CGFloat = 0,
                       priority: UILayoutPriority = .required,
                       activate: Bool = true) -> SelfConstraintBuilder {
        
        let constraint = makeDimensionConstraint(anchor: constrainable.heightAnchor,
                                                 relation: relation,
                                                 constant: constant,
                                                 priority: priority,
                                                 activate: activate)
        
        constraints.append(constraint)
        return self
    }
    
    /**
     Constrains width and height anchors individually to the same constant.
     - NOTE: Creates two constraints.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal,
                            constant: CGFloat = 0,
                            priority: UILayoutPriority = .required,
                            activate: Bool = true) -> SelfConstraintBuilder {
        
        width(relation, constant: constant, priority: priority, activate: activate)
        height(relation, constant: constant, priority: priority, activate: activate)
        return self
    }
    
    /**
     Constrains width and height anchors individually to the CGSize's width and height respectively.
     - NOTE: Creates two constraints.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal,
                            size: CGSize = .zero,
                            priority: UILayoutPriority = .required,
                            activate: Bool = true) -> SelfConstraintBuilder {
        
        width(relation, constant: size.width, priority: priority, activate: activate)
        height(relation, constant: size.height, priority: priority, activate: activate)
        return self
    }
    
    /**
     Constrains the height anchor to the width anchor with an aspect ratio multiplier.
     - NOTE: Creates a single constraint.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    public func aspectRatio(_ aspectRatio: CGFloat,
                            priority: UILayoutPriority = .required,
                            activate: Bool = true) -> SelfConstraintBuilder {
        
        let constraint = constrainable.heightAnchor.constraint(equalTo: constrainable.widthAnchor, multiplier: aspectRatio)
        constraint.priority = priority
        if activate {
            constraint.isActive = true
        }
        constraints.append(constraint)
        return self
    }
}
