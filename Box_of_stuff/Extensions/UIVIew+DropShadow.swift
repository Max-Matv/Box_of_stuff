//
//  UIVIew+DropShadow.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 27.01.23.
//

import Foundation
import UIKit

extension UIView {
     func dropShadow(color: CGColor = UIColor.black.cgColor, offset: CGSize = CGSize(width: 5, height: 5), opacity: Float = 0.7, radius: CGFloat = 5) {
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}
