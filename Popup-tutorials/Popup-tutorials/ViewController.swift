//
//  ViewController.swift
//  Popup-tutorials
//
//  Created by Rakesh Kumar on 06/04/20.
//  Copyright © 2020 Rakesh Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ChooseColorVC.setBackGroundColor = { color in
            self.view.backgroundColor = color
        }
    }
    
    
    @IBAction func touchChooseAndSetButton(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let objVC = storyBoard.instantiateViewController(withIdentifier: "ChooseColorVC") as! ChooseColorVC
        objVC.modalPresentationStyle = .custom
        self.present(objVC, animated: true, completion: nil)
    }
}

