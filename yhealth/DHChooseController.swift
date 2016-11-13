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
    
    
    @IBOutlet weak var presentCB: UIButton!
    @IBOutlet weak var presentCBHealth: UIButton!
    var transition: JTMaterialTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.presentCB.layer.cornerRadius = 70 / 2.0
        self.presentCB.backgroundColor = UIColor(colorLiteralRed: 86.0 / 256.0, green: 188.0 / 256.0, blue: 138 / 256.0, alpha: 1.0)
        
        
        self.presentCB.addTarget(self, action: #selector(didPresentDentalControllerButtonTouch), for: .touchUpInside)
        

        
        self.presentCBHealth.layer.cornerRadius = 70 / 2.0
        self.presentCBHealth.backgroundColor = UIColor(colorLiteralRed: 245.0/256.0, green: 0.0 / 256.0, blue: 47 / 256.0, alpha: 1.0)
        
        
        self.presentCBHealth.addTarget(self, action: #selector(didPresentHealthControllerButtonTouch), for: .touchUpInside)
        
        
        self.transition = JTMaterialTransition(animatedView: self.presentCB!)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    func didPresentDentalControllerButtonTouch () {
        let controller = SecondViewController()
        
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self.transition
        self.present(controller, animated: true, completion: nil)
        
        
        
    }

    func didPresentHealthControllerButtonTouch () {
        let controller = SecondHealthViewController()
        
        controller.modalPresentationStyle = .custom
        controller.transitioningDelegate = self.transition
        self.present(controller, animated: true, completion: nil)
        
        
        
    }


}
