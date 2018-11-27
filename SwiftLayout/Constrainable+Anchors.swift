//
//  Constrainable+Anchors.swift
//  SwiftLayout
//
//  Created by Jake Sawyer on 11/27/18.
//  Copyright © 2018 it.swiftkick. All rights reserved.
//

import UIKit

// MARK: - Anchor Infos on Constrainable

extension Constrainable {
    var leadingAnchorInfo: AnchorInfo<NSLayoutXAxisAnchor> { return AnchorInfo(item: self, attribute: .leading, anchor: self.leadingAnchor) }
    var trailingAnchorInfo: AnchorInfo<NSLayoutXAxisAnchor> { return AnchorInfo(item: self, attribute: .trailing, anchor: self.trailingAnchor) }
    var topAnchorInfo: AnchorInfo<NSLayoutYAxisAnchor> { return AnchorInfo(item: self, attribute: .top, anchor: self.topAnchor) }
    var bottomAnchorInfo: AnchorInfo<NSLayoutYAxisAnchor> { return AnchorInfo(item: self, attribute: .bottom, anchor: self.bottomAnchor) }
    var widthAnchorInfo: AnchorInfo<NSLayoutDimension> { return AnchorInfo(item: self, attribute: .width, anchor: self.widthAnchor) }
    var heightAnchorInfo: AnchorInfo<NSLayoutDimension> { return AnchorInfo(item: self, attribute: .height, anchor: self.heightAnchor) }
    var centerXAnchorInfo: AnchorInfo<NSLayoutXAxisAnchor> { return AnchorInfo(item: self, attribute: .centerX, anchor: self.centerXAnchor) }
    var centerYAnchorInfo: AnchorInfo<NSLayoutYAxisAnchor> { return AnchorInfo(item: self, attribute: .centerY, anchor: self.centerYAnchor) }
}

// MARK: - Getting AnchorInfos from enums

extension Constrainable {
    func anchorInfo(xAxis anchorType: XAxisAnchor) -> AnchorInfo<NSLayoutXAxisAnchor> {
        switch anchorType {
        case .leading: return leadingAnchorInfo
        case .trailing: return trailingAnchorInfo
        case .centerX: return centerXAnchorInfo
        }
    }
    
    func anchorInfo(yAxis anchorType: YAxisAnchor) -> AnchorInfo<NSLayoutYAxisAnchor> {
        switch anchorType {
        case .top: return topAnchorInfo
        case .bottom: return bottomAnchorInfo
        case .centerY: return centerYAnchorInfo
        }
    }
    
    func anchorInfo(dimension anchorType: DimensionAnchor) -> AnchorInfo<NSLayoutDimension> {
        switch anchorType {
        case .width: return widthAnchorInfo
        case .height: return heightAnchorInfo
        }
    }
}
