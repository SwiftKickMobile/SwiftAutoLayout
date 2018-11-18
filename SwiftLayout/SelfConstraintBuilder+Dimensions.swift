//
//  SelfConstraintBuilder+Dimensions.swift
//  BootstrapConstrainable
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import UIKit

public extension SelfConstraintBuilder {
    
    @discardableResult
    public func width(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        constraints.append(makeDimensionConstraint(anchor: constrainable.widthAnchor, relation: relation, constant: constant, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    public func height(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        constraints.append(makeDimensionConstraint(anchor: constrainable.heightAnchor, relation: relation, constant: constant, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    public func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        width(relation, constant: constant, priority: priority, activate: activate)
        height(relation, constant: constant, priority: priority, activate: activate)
        return self
    }
    
    @discardableResult
    public func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal, size: CGSize = .zero, priority: UILayoutPriority = .required, activate: Bool = true) -> SelfConstraintBuilder {
        width(relation, constant: size.width, priority: priority, activate: activate)
        height(relation, constant: size.height, priority: priority, activate: activate)
        return self
    }
    
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
