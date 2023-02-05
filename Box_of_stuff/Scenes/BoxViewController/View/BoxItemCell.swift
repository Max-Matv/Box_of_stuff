//
//  BoxItemCell.swift
//  Box_of_stuff
//
//  Created by Maksim Matveichuk on 30.10.22.
//

import UIKit

class BoxItemCell: UICollectionViewCell {
    
    private var image: UIImageView!
    private var text: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ item: BoxItem) {
        image.image = UIImage(systemName: item.image)
        text.text = item.name
    }
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circleAttributes = layoutAttributes as! CircleCollectionViewLayoutAttributes
        self.layer.anchorPoint = circleAttributes.anchorPoint
        self.center.y += (circleAttributes.anchorPoint.y - 0.5) * CGRectGetHeight(self.bounds)
    }
    
    private func setup() {
        image = UIImageView()
        text = UILabel()
        image.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        addSubview(text)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1.0/1.0),
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
            text.topAnchor.constraint(equalTo: image.bottomAnchor)
        ])
        text.textAlignment = .center
        layer.cornerRadius = 20
        image.tintColor = .red
        backgroundColor = .gray
    }
}
