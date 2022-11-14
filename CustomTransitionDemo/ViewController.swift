//
//  ViewController.swift
//  CustomTransitionDemo
//
//  Created by fahreddin on 13.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    
    let animator = PopAnimator()
    let models: [Pet] = [
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!),
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!),
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!),
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!),
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!),
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!),
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!),
        Pet(name: "Leo", kind: "Cat", image: UIImage(named: "cartoon-cat")!)
    ]
    
    let numberOfSections: Int = 1
    let itemHeight: CGFloat = 250
    let insets =  UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(PetCell.self, forCellWithReuseIdentifier: PetCell.description())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }


}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return numberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PetCell.description(),
                                                      for: indexPath) as! PetCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        let petDetailVC = PetDetailViewController()
        petDetailVC.modalPresentationStyle = .fullScreen
        petDetailVC.transitioningDelegate = self
        petDetailVC.model = model
        present(petDetailVC, animated: true, completion: nil)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = (view.frame.width / 2) - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: itemHeight)
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
              let indexPath = selectedIndexPaths.first,
              let selectedCell = collectionView.cellForItem(at: indexPath) as? PetCell,
              let selectedCellSuperview = selectedCell.superview else { return nil }
        
        animator.originFrame = selectedCellSuperview.convert(selectedCell.frame, to: nil)
        animator.originFrame = CGRect(
            x: animator.originFrame.origin.x,
            y: animator.originFrame.origin.y,
            width: animator.originFrame.size.width,
            height: animator.originFrame.size.height
        )
        
        animator.presenting = true
        
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.presenting = false
        return animator
    }
    
}
