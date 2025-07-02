//
//  Extension+UIButton.swift
//  MyNotes
//
//  Created by apple on 24/06/25.
//

import UIKit

extension UIButton {
    func addBorder(width: CGFloat, color: UIColor, cornerRadius: CGFloat) {
            self.layer.borderWidth = width
            self.layer.borderColor = color.cgColor
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
    }
}
