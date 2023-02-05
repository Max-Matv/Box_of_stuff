//
//  CircleCollectionViewLayoutAttributes.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 2.02.23.
//

import UIKit

class CircleCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {

    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        // 2
        didSet {
          zIndex = Int(angle * 1000000)
          transform = CGAffineTransformMakeRotation(angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copiedAttributes: CircleCollectionViewLayoutAttributes = super.copy(with: zone) as! CircleCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}
