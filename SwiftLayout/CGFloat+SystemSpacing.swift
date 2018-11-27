//
//  CGFloat+SystemSpacing.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 11/27/18.
//  Copyright © 2018 it.swiftkick. All rights reserved.
//

import UIKit

public extension CGFloat {
    /**
     This value is only useful when using SwiftLayout to define a constraint that should use system spacing.
     It is a nonsense value of `-9999` in all other scenarios.
     
     ```
     // Constrain the leading anchors of both `view` and `otherView` by the system-determined appropriate spacing.
     view.constrain(to: otherView).leading(constant: .systemSpacing)
     ```
     */
    @available(iOS 11, *)
    public static var systemSpacing: CGFloat { return -9999 }
}
