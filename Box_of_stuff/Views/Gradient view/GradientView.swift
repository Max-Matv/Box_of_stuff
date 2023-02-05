//
//  GradientView.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 27.01.23.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    private let topColor: CGColor = UIColor(named: "top")!.cgColor
    private let midleColor: CGColor = UIColor.darkGray.cgColor
    private let bottomColor: CGColor = UIColor(named: "bottom")!.cgColor
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        gradientLayer.colors = [topColor, bottomColor]
        layer.addSublayer(gradientLayer)
        backgroundColor = .orange
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
}
