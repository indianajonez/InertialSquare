//
//  ViewController.swift
//  InertialSquare
//
//  Created by Ekaterina Saveleva on 18.07.2023.
//


import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - Private properties
    
    private var snapBehavior: UISnapBehavior!
    private var follow: UICollisionBehavior!
    private var animator: UIDynamicAnimator!

    private lazy var squareView: UIView = {
       let view = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 10
        view.layer.cornerCurve = .continuous
        return view
    }()
    
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .systemBackground
        view.addSubview(squareView)
        setupGesture()
        animator = UIDynamicAnimator(referenceView: view)

    }
    
    
    // MARK: - Private methods
    
    private func setupGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        gesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapView(_ sender: UITapGestureRecognizer) {
        animateRectangle(sender.location(in: self.view))
    }
    
    private func animateRectangle(_ point: CGPoint) {
        animator.removeAllBehaviors()
        
        follow = UICollisionBehavior(items: [squareView])
        follow.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(follow)
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: point)
        snapBehavior.damping = 1.0
        animator.addBehavior(snapBehavior)
        squareView.center = point
   
    }
   

}
