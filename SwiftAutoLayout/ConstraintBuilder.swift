//
//  ConstraintBuilder.swift
//  SwiftAutoLayout
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

// Look at all this code you didn't have to write!

import Foundation
import UIKit

/**
 Protocol for defining constraint builders.
 All builders should be able to return their constraints in the order they've been built.
 */
public protocol ConstraintBuilder {
    var constraints: [NSLayoutConstraint] { get }
}

// MARK: - Create Constraints
extension ConstraintBuilder {
    /**
     Attempts to create a constraint between `first` and `second` anchors without activating it.
     - Note: Will inverse the `first` and `second` anchors if parameter `inverse` is true — useful for creating constraints relating to `trailingAnchor` or `bottomAnchor`s
     - Parameters:
     - first: The first anchor to constrain against the second.
     - second: The second anchor to which the first is constraining.
     - inverse: Optional — If true, the `first` and `second` anchors will be inverted when creating this constraint. Useful for keeping constants positive. Defaults to `false`.
     - Returns: The created constraint. This method does not activate the constraint.
     */
    func makeConstraint<T>(first rawFirst: AnchorInfo<T>,
                           second rawSecond: AnchorInfo<T>,
                           relation: NSLayoutConstraint.Relation,
                           constant: CGFloat,
                           multiplier: CGFloat,
                           priority: UILayoutPriority,
                           activate: Bool,
                           inverse: Bool = false) -> NSLayoutConstraint {
        
        let first = inverse ? rawSecond : rawFirst
        let second = inverse ? rawFirst : rawSecond
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal:
            if #available(iOS 11, *),
                constant == .systemSpacing,
                let first = first.anchor as? NSLayoutXAxisAnchor,
                let second = second.anchor as? NSLayoutXAxisAnchor {
                // do not set constant
                constraint = first.constraint(equalToSystemSpacingAfter: second, multiplier: multiplier)
            } else if #available(iOS 11, *),
                constant == .systemSpacing,
                let first = first.anchor as? NSLayoutYAxisAnchor,
                let second = second.anchor as? NSLayoutYAxisAnchor {
                constraint = first.constraint(equalToSystemSpacingBelow: second, multiplier: multiplier)
            } else {
                constraint = NSLayoutConstraint(item: first.item,
                                                attribute: first.attribute,
                                                relatedBy: .equal,
                                                toItem: second.item,
                                                attribute: second.attribute,
                                                multiplier: multiplier,
                                                constant: constant)
            }
        case .lessThanOrEqual:
            if #available(iOS 11, *),
                constant == .systemSpacing,
                let first = first.anchor as? NSLayoutXAxisAnchor,
                let second = second.anchor as? NSLayoutXAxisAnchor {
                // do not set constant
                constraint = first.constraint(lessThanOrEqualToSystemSpacingAfter: second, multiplier: multiplier)
            } else if #available(iOS 11, *),
                constant == .systemSpacing,
                let first = first.anchor as? NSLayoutYAxisAnchor,
                let second = second.anchor as? NSLayoutYAxisAnchor {
                constraint = first.constraint(lessThanOrEqualToSystemSpacingBelow: second, multiplier: multiplier) 
            } else {
                constraint = NSLayoutConstraint(item: first.item,
                                                attribute: first.attribute,
                                                relatedBy: .lessThanOrEqual,
                                                toItem: second.item,
                                                attribute: second.attribute,
                                                multiplier: multiplier,
                                                constant: constant)
            }
        case .greaterThanOrEqual:
            if #available(iOS 11, *),
                constant == .systemSpacing,
                let first = first.anchor as? NSLayoutXAxisAnchor,
                let second = second.anchor as? NSLayoutXAxisAnchor {
                // do not set constant
                constraint = first.constraint(greaterThanOrEqualToSystemSpacingAfter: second, multiplier: multiplier)
            } else if #available(iOS 11, *),
                constant == .systemSpacing,
                let first = first.anchor as? NSLayoutYAxisAnchor,
                let second = second.anchor as? NSLayoutYAxisAnchor {
                constraint = first.constraint(greaterThanOrEqualToSystemSpacingBelow: second, multiplier: multiplier)
            } else {
                constraint = NSLayoutConstraint(item: first.item,
                                                attribute: first.attribute,
                                                relatedBy: .greaterThanOrEqual,
                                                toItem: second.item,
                                                attribute: second.attribute,
                                                multiplier: multiplier,
                                                constant: constant)
            }
        }
        constraint.priority = priority
        if activate {
            constraint.isActive = true
        }
        return constraint
    }
}
