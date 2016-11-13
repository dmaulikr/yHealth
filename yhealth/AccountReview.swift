//
//  AccountReview.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/12/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit


class AccountReview: UIViewController {
    
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var lname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var age: UILabel!
    
    var FBProfile: [String: AnyObject] = [:]
    var FBPassedProf: [String: AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         self.FBProfile = FBPassedProf
        
        fname.text = self.FBProfile["first_name"] as! String?
        lname.text = self.FBProfile["last_name"] as! String?
        email.text = self.FBProfile["email"] as! String?
        gender.text = self.FBProfile["gender"] as! String?
        
        
        let min = self.FBProfile["age_range"]!["min"]!! as! NSNumber
        let max = self.FBProfile["age_range"]!["max"]!! as! NSNumber
        
        age.text = "\(min) - \(max)"
        
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 }
