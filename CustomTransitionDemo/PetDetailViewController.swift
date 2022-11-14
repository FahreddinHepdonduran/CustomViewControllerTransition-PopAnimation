//
//  PetDetailViewController.swift
//  CustomTransitionDemo
//
//  Created by fahreddin on 13.11.2022.
//

import UIKit

class PetDetailViewController: UIViewController {
    
    var imageView: UIImageView!
    var nameLabel: UILabel!
    var kindLabel: UILabel!
    var stackView: UIStackView!
    
    var model: Pet!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        configure()
    }
    
    func configure() {
        imageView.image = model.image
        nameLabel.text = "Name: \(model.name)"
        kindLabel.text = "Kind: \(model.kind)"
    }
    
    func setUpViews() {
        stackView = UIStackView(frame: CGRect(x: view.frame.width * 0.05,
                                              y: 0.0,
                                              width: view.frame.width * 0.9,
                                              height: view.frame.height * 0.6))
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.distribution = .fill
        stackView.alignment = .fill
        view.addSubview(stackView)
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        stackView.addArrangedSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18.0)
        nameLabel.minimumScaleFactor = 0.1
        stackView.addArrangedSubview(nameLabel)
        
        kindLabel = UILabel()
        kindLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.backgroundColor = .clear
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18.0)
        nameLabel.minimumScaleFactor = 0.1
        stackView.addArrangedSubview(kindLabel)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: stackView.frame.height * 0.8)
        ])
        
        let closeButton = UIButton(frame: CGRect(x: 0.0, y: 30.0, width: 50.0, height: 50.0))
        closeButton.setImage(UIImage(named: "cancel"), for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        view.insertSubview(closeButton, aboveSubview: stackView)
    }
    
    @objc
    func closeButtonAction() {
        dismiss(animated: true, completion: nil)
    }

}
