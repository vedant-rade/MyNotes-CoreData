//
//  Extension+UIView.swift
//  MyNotes
//
//  Created by apple on 24/06/25.
//

import UIKit

extension UIView {
    func roundCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.maskedCorners = corners.toCACornerMask()
    }
}

extension UIRectCorner {
    func toCACornerMask() -> CACornerMask {
        var maskedCorners: CACornerMask = []

        if self.contains(.topLeft) {
            maskedCorners.insert(.layerMinXMinYCorner)
        }
        if self.contains(.topRight) {
            maskedCorners.insert(.layerMaxXMinYCorner)
        }
        if self.contains(.bottomLeft) {
            maskedCorners.insert(.layerMinXMaxYCorner)
        }
        if self.contains(.bottomRight) {
            maskedCorners.insert(.layerMaxXMaxYCorner)
        }

        return maskedCorners
    }
}

