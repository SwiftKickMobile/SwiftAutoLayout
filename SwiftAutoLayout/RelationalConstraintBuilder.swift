//
//  RelationalConstraintBuilder.swift
//  SwiftAutoLayout
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

// Look at all this code you didn't have to write!

import Foundation
import UIKit

/**
 Creates constraints between two `Constrainable`s, usually by matching anchors.
 It can do custom constraints as well via its `xAxis(_:to:)`, `yAxis(_:to:)`, and `dimension(_:to:)` methods.
 */
public class RelationalConstraintBuilder: ConstraintBuilder {
    
    /// The constraints created by this builder, in the order they were made.
    public internal(set) var constraints = [NSLayoutConstraint]()
    
    let firstConstrainable: Constrainable
    let secondConstrainable: Constrainable
    
    /**
     If the first constrainable doesn't have a parent or owning view, the second will become it.
     If the first constrainable is a view, its `translatesAutoresizingMaskIntoConstraints` will be disabled.
     */
    init(first firstConstrainable: Constrainable, second secondConstrainable: Constrainable) {
        self.firstConstrainable = firstConstrainable
        self.secondConstrainable = secondConstrainable

        UIView.performWithoutAnimation {
            if let view = firstConstrainable as? UIView {
                view.translatesAutoresizingMaskIntoConstraints = false
                if view.superview == nil {
                    if let otherView = secondConstrainable as? UIView {
                        otherView.addSubview(view)
                    } else if let otherLayoutGuide = secondConstrainable as? UILayoutGuide, let otherView = otherLayoutGuide.owningView {
                        otherView.addSubview(view)
                    }
                }
            } else if let layoutGuide = firstConstrainable as? UILayoutGuide, layoutGuide.owningView == nil {
                if let otherView = secondConstrainable as? UIView {
                    otherView.addLayoutGuide(layoutGuide)
                } else if let otherGuide = secondConstrainable as? UILayoutGuide, let otherView = otherGuide.owningView {
                    otherView.addLayoutGuide(layoutGuide)
                }
            }
        }
    }
}

// MARK: - Edge Constraints
public extension RelationalConstraintBuilder {
    /**
     Constrains both leading anchors together.
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
    func leading(_ relation: NSLayoutConstraint.Relation = .equal,
                 constant: CGFloat = 0,
                 multiplier: CGFloat = 1,
                 priority: UILayoutPriority = .required,
                 activate: Bool = true) -> RelationalConstraintBuilder {
        
        let constraint = makeConstraint(first: firstConstrainable.leadingAnchorInfo,
                                        second: secondConstrainable.leadingAnchorInfo,
                                        relation: relation,
                                        constant: constant,
                                        multiplier: multiplier,
                                        priority: priority,
                                        activate: activate)
        
        constraints.append(constraint)
        return self
    }
    
    /**
     Constrains both trailing anchors together.
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
    func trailing(_ relation: NSLayoutConstraint.Relation = .equal,
                  constant: CGFloat = 0,
                  multiplier: CGFloat = 1,
                  priority: UILayoutPriority = .required,
                  activate: Bool = true) -> RelationalConstraintBuilder {
        
        let constraint = makeConstraint(first: firstConstrainable.trailingAnchorInfo,
                                        second: secondConstrainable.trailingAnchorInfo,
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
     Constrains both leading and trailing anchors together with the same criteria.
     - NOTE: Creates two constraints.
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
                         activate: Bool = true) -> RelationalConstraintBuilder {
        
        leading(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        trailing(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
    /**
     Constrains both top anchors together.
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
    func top(_ relation: NSLayoutConstraint.Relation = .equal,
             constant: CGFloat = 0,
             multiplier: CGFloat = 1,
             priority: UILayoutPriority = .required,
             activate: Bool = true) -> RelationalConstraintBuilder {
        
        constraints.append(makeConstraint(first: firstConstrainable.topAnchorInfo, second: secondConstrainable.topAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     Constrains both bottom anchors together.
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
    func bottom(_ relation: NSLayoutConstraint.Relation = .equal,
                constant: CGFloat = 0,
                multiplier: CGFloat = 1,
                priority: UILayoutPriority = .required,
                activate: Bool = true) -> RelationalConstraintBuilder {
        
        constraints.append(makeConstraint(first: firstConstrainable.bottomAnchorInfo, second: secondConstrainable.bottomAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate, inverse: true))
        return self
    }
    
    /**
     Constrains both top and bottom anchors together with the same criteria.
     - NOTE: Creates two constraints.
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
                   activate: Bool = true) -> RelationalConstraintBuilder {
        
        top(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        bottom(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
    /**
     Constrains both leading, trailing, top, and bottom anchors together with the same criteria.
     - NOTE: Creates four constraints.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func leadingTrailingTopBottom(_ relation: NSLayoutConstraint.Relation = .equal,
                                  constant: CGFloat = 0,
                                  multiplier: CGFloat = 1,
                                  priority: UILayoutPriority = .required,
                                  activate: Bool = true) -> RelationalConstraintBuilder {
        
        leadingTrailing(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        topBottom(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
}

// MARK: - Spacing Constraints
public extension RelationalConstraintBuilder {
    
    /**
     Constrains both centerX anchors together.
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
    func centerX(_ relation: NSLayoutConstraint.Relation = .equal,
                 constant: CGFloat = 0,
                 multiplier: CGFloat = 1,
                 priority: UILayoutPriority = .required,
                 activate: Bool = true) -> RelationalConstraintBuilder {
        
        constraints.append(makeConstraint(first: firstConstrainable.centerXAnchorInfo, second: secondConstrainable.centerXAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     Constrains both centerY anchors together.
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
    func centerY(_ relation: NSLayoutConstraint.Relation = .equal,
                 constant: CGFloat = 0,
                 multiplier: CGFloat = 1,
                 priority: UILayoutPriority = .required,
                 activate: Bool = true) -> RelationalConstraintBuilder {
        
        constraints.append(makeConstraint(first: firstConstrainable.centerYAnchorInfo, second: secondConstrainable.centerYAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     Constrains both centerX and centerY anchors together with the same criteria.
     - NOTE: Creates two constraints.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func centerXY(_ relation: NSLayoutConstraint.Relation = .equal,
                  constant: CGFloat = 0,
                  multiplier: CGFloat = 1,
                  priority: UILayoutPriority = .required,
                  activate: Bool = true) -> RelationalConstraintBuilder {
        
        centerX(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        centerY(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
    
}

// MARK: - Dimension Constraints
public extension RelationalConstraintBuilder {
    /**
     Constrains both width anchors together.
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
    func width(_ relation: NSLayoutConstraint.Relation = .equal,
               constant: CGFloat = 0,
               multiplier: CGFloat = 1,
               priority: UILayoutPriority = .required,
               activate: Bool = true) -> RelationalConstraintBuilder {
        
        constraints.append(makeConstraint(first: firstConstrainable.widthAnchorInfo, second: secondConstrainable.widthAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     Constrains both height anchors together.
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
    func height(_ relation: NSLayoutConstraint.Relation = .equal,
                constant: CGFloat = 0,
                multiplier: CGFloat = 1,
                priority: UILayoutPriority = .required,
                activate: Bool = true) -> RelationalConstraintBuilder {
        
        constraints.append(makeConstraint(first: firstConstrainable.heightAnchorInfo, second: secondConstrainable.heightAnchorInfo, relation: relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate))
        return self
    }
    
    /**
     Constrains both width and height anchors together with the same criteria.
     - NOTE: Creates two constraints.
     - Parameters:
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     */
    @discardableResult
    func widthHeight(_ relation: NSLayoutConstraint.Relation = .equal,
                     constant: CGFloat = 0,
                     multiplier: CGFloat = 1,
                     priority: UILayoutPriority = .required,
                     activate: Bool = true) -> RelationalConstraintBuilder {
        
        width(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        height(relation, constant: constant, multiplier: multiplier, priority: priority, activate: activate)
        return self
    }
}

// MARK: - Custom Constraints
public extension RelationalConstraintBuilder {
    
    /**
     Method for building custom constraints between two different NSLayoutXAnchor anchors.
     If you want to constrain the same anchors across two constrainables, just use their named method. IE, `view.constrain(to: otherView).leading()`
     
     - NOTE: Creates a single constraint.
     - Parameters:
         - firstAnchor: This constrainable's NSLayoutXAnchor that will be constrained to the other constrainable's anchor.
         - secondAnchor: The other constrainable's NSLayoutXAnchor that will be constrained to our constrainable's anchor.
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     
     ```
     // Constrain view's centerX anchor to another view's leading anchor
     view.constrain(to: otherView).xAxis(.centerX, to: .leading)
     
     // Modify the optional arguments to specify a more advanced constraint
     view.constrain(to: otherView).xAxis(.centerX, to: .leading, relation: .lessThanOrEqual, constant: 0, multiplier: 0.5, activate: false)
     
     // Use the constraint builder returned after each newly created constraint to access the constraints created in order
     let constraint = view.constrain(to: otherView).xAxis(.centerX, to: .leading, constant: 0, priority: .defaultHigh, activate: false).constraints.last!
     constraint.isActive = true // activate the constraint later
     ```
     */
    @discardableResult
    func xAxis(_ firstAnchor: XAxisAnchor,
               to secondAnchor: XAxisAnchor,
               relation: NSLayoutConstraint.Relation = .equal,
               constant: CGFloat = 0,
               multiplier: CGFloat = 1,
               priority: UILayoutPriority = .required,
               activate: Bool = true) -> RelationalConstraintBuilder {
        
        let constraint = makeConstraint(first: firstConstrainable.anchorInfo(xAxis: firstAnchor),
                                        second: secondConstrainable.anchorInfo(xAxis: secondAnchor),
                                        relation: relation,
                                        constant: constant,
                                        multiplier: multiplier,
                                        priority: priority,
                                        activate: activate)
        
        constraints.append(constraint)
        return self
    }
    
    /**
     Method for building custom constraints between two different NSLayoutYAnchor anchors.
     If you want to constrain the same anchors across two constrainables, just use their named method. IE, `view.constrain(to: otherView).top()`
     
     - NOTE: Creates a single constraint.
     - Parameters:
         - firstAnchor: This constrainable's NSLayoutYAnchor that will be constrained to the other constrainable's anchor.
         - secondAnchor: The other constrainable's NSLayoutYAnchor that will be constrained to our constrainable's anchor.
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     
     ```
     // Constrain view's centerY anchor to another view's bottom anchor
     view.constrain(to: otherView).yAxis(.centerY, to: .bottom)
     
     // Modify the optional arguments to specify a more advanced constraint
     view.constrain(to: otherView).yAxis(.centerY, to: .bottom, relation: .lessThanOrEqual, constant: 0, multiplier: 0.5, activate: false)
     
     // Use the constraint builder returned after each newly created constraint to access the constraints created in order
     let constraint = view.constrain(to: otherView).yAxis(.centerY, to: .bottom, constant: 0, priority: .defaultHigh, activate: false).constraints.last!
     constraint.isActive = true // activate the constraint later
     ```
     */
    @discardableResult
    func yAxis(_ firstAnchor: YAxisAnchor,
               to secondAnchor: YAxisAnchor,
               relation: NSLayoutConstraint.Relation = .equal,
               constant: CGFloat = 0,
               multiplier: CGFloat = 1,
               priority: UILayoutPriority = .required,
               activate: Bool = true) -> RelationalConstraintBuilder {
        
        let constraint = makeConstraint(first: firstConstrainable.anchorInfo(yAxis: firstAnchor),
                                        second: secondConstrainable.anchorInfo(yAxis: secondAnchor),
                                        relation: relation,
                                        constant: constant,
                                        multiplier: multiplier,
                                        priority: priority,
                                        activate: activate)
        
        constraints.append(constraint)
        return self
    }
    
    /**
     Method for building custom constraints between two different NSLayoutDimension anchors.
     If you want to constrain the same anchors across two constrainables, just use their named method. IE, `view.constrain(to: otherView).width()`
     
     - NOTE: Creates a single constraint.
     - Parameters:
         - firstAnchor: This constrainable's NSLayoutDimension anchor that will be constrained to the other constrainable's anchor.
         - secondAnchor: The other constrainable's NSLayoutDimension anchor that will be constrained to our constrainable's anchor.
         - relation: The relationship between the anchors. Defaults to `.equal`
         - constant: The constant for the constraint. Defaults to 0
         - multiplier: The multiplier for the constraint. Defaults to 1
         - priority: The priority for the constraint. Defaults to `.required`. Note that `.required` constraints must be activated and cannot be deactivated. Specify a lower value for dynamically activated constraints.
         - activate: Whether or not this constraint should be activated now. Disable this if you want to activate the constraint later.
     - Returns: The constraint builder. Access any constraints built so far in the order declared via its `constraints` property.
     
     ```
     // Constrain view's width anchor to another view's height anchor
     view.constrain(to: otherView).dimension(.width, to: .height)
     
     // Modify the optional arguments to specify a more advanced constraint
     view.constrain(to: otherView).dimension(.width, to: .height, relation: .lessThanOrEqual, constant: 0, multiplier: 0.5, activate: false)
     
     // Use the constraint builder returned after each newly created constraint to access the constraints created in order
     let constraint = view.constrain(to: otherView).dimension(.width, to: .height, constant: 0, priority: .defaultHigh, activate: false).constraints.last!
     constraint.isActive = true // activate the constraint later
     ```
     */
    @discardableResult
    func dimension(_ firstAnchor: DimensionAnchor,
                   to secondAnchor: DimensionAnchor,
                   relation: NSLayoutConstraint.Relation = .equal,
                   constant: CGFloat = 0,
                   multiplier: CGFloat = 1,
                   priority: UILayoutPriority = .required,
                   activate: Bool = true) -> RelationalConstraintBuilder {
        
        let constraint = makeConstraint(first: firstConstrainable.anchorInfo(dimension: firstAnchor),
                                        second: secondConstrainable.anchorInfo(dimension: secondAnchor),
                                        relation: relation,
                                        constant: constant,
                                        multiplier: multiplier,
                                        priority: priority,
                                        activate: activate)
        
        constraints.append(constraint)
        return self
    }
    
}
