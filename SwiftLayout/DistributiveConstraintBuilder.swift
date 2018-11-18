//
//  DistributiveConstraintBuilder.swift
//  BootstrapConstrainable
//
//  Created by Jake Sawyer on 11/13/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import Foundation
import UIKit

public class DistributiveConstraintBuilder: ConstraintBuilder {
    
    public let beforeConstrainable: Constrainable
    public let afterConstrainable: Constrainable
    
    public internal(set) var constraints = [NSLayoutConstraint]()
    
    public init(before beforeConstrainable: Constrainable, after afterConstrainable: Constrainable) {
        self.beforeConstrainable = beforeConstrainable
        self.afterConstrainable = afterConstrainable
        
        for view in [beforeConstrainable, afterConstrainable].compactMap({ $0 as? UIView }) {
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
