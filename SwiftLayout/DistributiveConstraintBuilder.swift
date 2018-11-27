//
//  DistributiveConstraintBuilder.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 11/13/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation
import UIKit

public class DistributiveConstraintBuilder: ConstraintBuilder {
    
    /// The horizontally and vertically first constrainable
    public let beforeConstrainable: Constrainable
    
    /// The horizontally and vertically second constrainable
    public let afterConstrainable: Constrainable
    
    /// The constraints created by this builder in the order they were created.
    public internal(set) var constraints = [NSLayoutConstraint]()
    
    /**
     Supplied constrainables, if they are `UIView`s, will have their `translatesAutoresizingMaskIntoConstraints` set to false.
     */
    public init(before beforeConstrainable: Constrainable, after afterConstrainable: Constrainable) {
        self.beforeConstrainable = beforeConstrainable
        self.afterConstrainable = afterConstrainable
        
        for view in [beforeConstrainable, afterConstrainable].compactMap({ $0 as? UIView }) {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
