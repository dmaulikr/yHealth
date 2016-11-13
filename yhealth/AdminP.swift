//
//  AdminP.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/13/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//


import UIKit

class AdminLogin: UIViewController {
    
    @IBOutlet weak var adminLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirm(_ sender: Any) {
        if adminLabel.text == "iamCAPtain." {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewC = storyboard.instantiateViewController(withIdentifier: "adminAnal")
            
            self.present(viewC, animated: true, completion: nil)
        }
    }
}
