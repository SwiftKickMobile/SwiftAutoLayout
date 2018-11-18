//
//  RelationalConstraintBuilder.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 10/23/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation
import UIKit

public class RelationalConstraintBuilder: ConstraintBuilder {
    
    public let firstConstrainable: Constrainable
    public let secondConstrainable: Constrainable
    
    public internal(set) var constraints = [NSLayoutConstraint]()
    
    init(first firstConstrainable: Constrainable, second secondConstrainable: Constrainable) {
        self.firstConstrainable = firstConstrainable
        self.secondConstrainable = secondConstrainable
        
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
