//
//  DHChooseController.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/13/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//


import UIKit
import JTMaterialTransition

class DHChooseController: UIViewController {
    
    
    weak var presentControllerButton: UIButton?
    var transition: JTMaterialTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createPresentControllerButton(width: 50)
        self.transition = JTMaterialTransition(animatedView: self.presentControllerButton!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func createPresentControllerButton (width: CGFloat) {
        
        let y: CGFloat = 300
        let height: CGFloat = width
        let x: CGFloat = (self.view.frame.width - width) / 2.0
        
        let presentControllerButton = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        presentControllerButton.layer.cornerRadius = width / 2.0
        presentControllerButton.backgroundColor = UIColor(colorLiteralRed: 86.0 / 256.0, green: 188.0 / 256.0, blue: 138 / 256.0, alpha: 1.0)
        
        presentControllerButton.setImage(UIImage(named: "plus"), for: .normal)
        presentControllerButton.addTarget(self, action: #selector(didPresentControllerButtonTouch), for: .touchUpInside)
        
        
        self.view.addSubview(presentControllerButton)
        self.presentControllerButton = presentControllerButton
    }

    
    func didPresentControllerButtonTouch () {
        let controller = SecondViewController()
        
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self.transition
        self.present(controller, animated: true, completion: nil)
    }

    


}