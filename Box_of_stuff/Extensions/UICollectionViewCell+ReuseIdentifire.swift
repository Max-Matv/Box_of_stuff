//
//  UICollectionViewCell+ReuseIdentifire.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 30.10.22.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifire: String {
        String(describing: self)
    }
}
