//
//  UITableView+ReuseIdentifire.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 10.11.22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifire: String {
        String(describing: self)
    }
}
