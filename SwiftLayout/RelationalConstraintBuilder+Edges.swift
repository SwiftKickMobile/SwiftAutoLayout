//
//  RelationalConstraintBuilder+Edges.swift
//  BootstrapConstrainable
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation
import UIKit

public extension RelationalConstraintBuilder {
    
    @discardableResult
    func leading(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.leadingInfo, second: secondConstrainable.leadingInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    func trailing(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.trailingInfo, second: secondConstrainable.trailingInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate, inverse: true))
        return self
    }
    
    @discardableResult
    func leadingTrailing(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        leading(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        trailing(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
    @discardableResult
    func top(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.topInfo, second: secondConstrainable.topInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    func bottom(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.bottomInfo, second: secondConstrainable.bottomInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate, inverse: true))
        return self
    }
    
    @discardableResult
    func topBottom(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        top(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        bottom(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
    @discardableResult
    func leadingTrailingTopBottom(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        leadingTrailing(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        topBottom(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
}
