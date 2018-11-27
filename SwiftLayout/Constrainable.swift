//
//  Constrainable.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 8/30/18.
//  Copyright © 2018 SwiftKick Mobile. All rights reserved.
//

import UIKit

/**
 Definition of a constrainable instance (usually a `UIView` or `UILayoutGuide`) and its anchors.
 ```
 // add constraints to a view with vertical padding
 view.constrain(to: otherView).leadingTrailing().topBottom(.lessThanOrEqual, constant: 8)
 ```
 
 - NOTE: This protocol does not include `baseline` anchors.
 */
public protocol Constrainable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

// Declare UIView and UILayoutGuide to be constrainable
extension UIView: Constrainable {}
extension UILayoutGuide: Constrainable {}
