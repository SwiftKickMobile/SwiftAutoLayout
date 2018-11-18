//
//  RelationalConstraintBuilder+Spacing.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation

public extension RelationalConstraintBuilder {
    
    @discardableResult
    func centerX(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.centerXInfo, second: secondConstrainable.centerXInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    func centerY(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.centerYInfo, second: secondConstrainable.centerYInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    func centerXY(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        centerX(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        centerY(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
}
