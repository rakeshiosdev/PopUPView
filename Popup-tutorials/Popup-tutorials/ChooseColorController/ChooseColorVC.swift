//
//  ChooseColorVC.swift
//  Popup-tutorials
//
//  Created by Rakesh Kumar on 06/04/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import UIKit

class ChooseColorVC: UIViewController {
    
    
    lazy var backdropView: UIView = {
        let bdView = UIView(frame: self.view.bounds)
        bdView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return bdView
    }()
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var colorTableView: UITableView!
    
    var containerHeight = CGFloat(100)//UIScreen.main.bounds.height / 2
    var isPresenting = false
    
    @IBOutlet weak var tblHightConst: NSLayoutConstraint!
    @IBOutlet weak var containerViewHeightConst: NSLayoutConstraint!
    
    static var setBackGroundColor: ((_ color: UIColor) ->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tblHightConst.constant = CGFloat(50 * 10)
        containerViewHeightConst.constant = CGFloat(25 + 50 * 10)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
        
        self.view.backgroundColor = .clear
        self.view.addSubview(backdropView)
        self.view.sendSubviewToBack(backdropView)
        isPresenting = true
        containerView.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ChooseColorVC.handleTap(_:)))
        backdropView.addGestureRecognizer(tapGesture)
        
        colorTableView.delegate = self
        colorTableView.dataSource = self
        colorTableView.reloadData()
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}

extension ChooseColorVC: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        guard let toVC = toViewController else { return }
        isPresenting = !isPresenting
        
        if isPresenting == true {
            containerView.addSubview(toVC.view)
            
            containerView.frame.origin.y += containerHeight
            backdropView.alpha = 0
            
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.containerView.frame.origin.y -= self.containerHeight
                self.backdropView.alpha = 1
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseOut], animations: {
                self.containerView.frame.origin.y += self.containerHeight
                self.backdropView.alpha = 0
            }, completion: { (finished) in
                transitionContext.completeTransition(true)
            })
        }
    }
}

//MARK:- UITableView Delegate & DataSource
extension ChooseColorVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = colorTableView.dequeueReusableCell(withIdentifier: "ColorCell", for: indexPath) as! ColorCell
        cell.backgroundColor = .random
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = colorTableView.cellForRow(at: indexPath) as! ColorCell
        
        self.dismiss(animated: true, completion: nil)
        if let closure = ChooseColorVC.setBackGroundColor {
            closure(currentCell.backgroundColor!)
        }
    }
}


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
