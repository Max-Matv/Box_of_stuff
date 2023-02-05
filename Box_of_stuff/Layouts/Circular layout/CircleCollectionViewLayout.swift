//
//  CircleCollectionViewLayout.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 2.02.23.
//

import UIKit

class CircleCollectionViewLayout: UICollectionViewLayout {

    private var attributesList = [CircleCollectionViewLayoutAttributes]()
    private let itemSize = CGSize(width: 200, height: 200)
    private var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    private var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - CGRectGetWidth(collectionView!.bounds))
    }
    private var radius: CGFloat = 450 {
        didSet {
          invalidateLayout()
        }
    }
    private var anglePerItem: CGFloat {
        return atan(itemSize.width / radius)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width,
              height: CGRectGetHeight(collectionView!.bounds))
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CircleCollectionViewLayoutAttributes.self
    }
    
    override func prepare() {
        super.prepare()
        let centerX = collectionView!.contentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 3)
        let anchorPointY = ((itemSize.height ) + radius) / itemSize.height
        attributesList = (0..<collectionView!.numberOfItems(inSection: 0)).compactMap { i -> CircleCollectionViewLayoutAttributes in
            let attributes = CircleCollectionViewLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: CGRectGetMidY(self.collectionView!.bounds) * 1.2)
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        self.attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    
}
