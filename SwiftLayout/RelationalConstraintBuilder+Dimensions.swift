//
//  RelationalConstraintBuilder+Dimensions.swift
//  BootstrapConstrainable
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation

public extension RelationalConstraintBuilder {
    
    @discardableResult
    func width(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.widthInfo, second: secondConstrainable.widthInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    func height(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        constraints.append(makeConstraint(first: firstConstrainable.heightInfo, second: secondConstrainable.heightInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    @discardableResult
    func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal, constant: CGFloat = 0, multiplier: CGFloat = 1, priority: UILayoutPriority = .required, activate: Bool = true) -> RelationalConstraintBuilder {
        width(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        height(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
}
