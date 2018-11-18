//
//  DistributiveConstraintBuilder+Edges.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 11/13/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation

public extension DistributiveConstraintBuilder {
    
    @discardableResult
    func leadingTrailing(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> DistributiveConstraintBuilder {
        constraints.append(makeConstraint(first: beforeConstrainable.trailingInfo, second: afterConstrainable.leadingInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate, inverse: true))
        return self
    }
    
    @discardableResult
    func topBottom(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> DistributiveConstraintBuilder {
        constraints.append(makeConstraint(first: beforeConstrainable.bottomInfo, second: afterConstrainable.topInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate, inverse: true))
        return self
    }
    
}
