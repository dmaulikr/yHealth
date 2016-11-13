//
//  AccountReview.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/12/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit


class AccountReview: UIViewController {
    
    @IBOutlet weak var fname: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var age: UITextField!
    
    var FBProfile: [String: AnyObject] = [:]
    var FBPassedProf: [String: AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap: UIGestureRecognizer = UIGestureRecognizer(target: self, action: "dismissKey")
        view.addGestureRecognizer(tap)
        
        self.FBProfile = FBPassedProf
        print("PRINTING FB PASSED DATA \(FBProfile)")
        
        fname.text = self.FBProfile["first_name"] as! String?
        lname.text = self.FBProfile["last_name"] as! String?
        email.text = self.FBProfile["email"] as! String?
        gender.text = self.FBProfile["gender"] as! String?
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func confirmedButt(_ sender: Any) {
    
    }
    
    func dismissKey (){
        view.endEditing(true)
    }
    
}
