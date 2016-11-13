//
//  SecondViewController.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/13/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit

class SecondHealthViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(colorLiteralRed: 54.0 / 256.0, green: 70.0 / 256.0, blue: 93 / 256.0, alpha: 1.0)
        
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 300, y: 385)
        label.textAlignment = .center
        label.text = "YOU CHOSE HEALTH"
        label.textColor = UIColor.white
        self.view.addSubview(label)
        
        createCloseButton()
        
    }
    
    func createCloseButton () {
        let y: CGFloat = 500.0
        let width: CGFloat = 50.0
        let height: CGFloat = width
        let x: CGFloat = (575.0 - width) / 2.0
        
        let closeButton = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(self, action: #selector(didCloseButtonTouch), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    
    func didCloseButtonTouch () {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewC = storyboard.instantiateViewController(withIdentifier: "healthCOPAY")
        self.present(viewC, animated: true, completion: nil)
    }
    
}
