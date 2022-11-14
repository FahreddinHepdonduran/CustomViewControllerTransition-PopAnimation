//
//  PetCell.swift
//  CustomTransitionDemo
//
//  Created by fahreddin on 13.11.2022.
//

import UIKit

class PetCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    
    override class func description() -> String {
        return  "PetCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: Pet) {
        imageView.image = model.image
    }
    
    func setUpViews() {
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
}
