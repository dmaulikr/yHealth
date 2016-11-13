//
//  ViewController.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/11/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookShare
import FBSDKCoreKit

class FacebookController: UIViewController {
    
    var adminTouch: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if (segue.identifier == "accountReview"){
//        
//            var svc = segue!.destinationViewController as AccountReview
//            
//            
//            svc.toPass = ["blah", "bleeh", "boop"]
//        }
//    }
//
    @IBAction func facebookLogin(_ sender: AnyObject) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
                case .failed(let error):
                    print(error)
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):

                    let params = ["fields":"first_name,last_name,age_range,gender,locale,email"]
                    
                    let request:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/\(accessToken.userId!)", parameters: params, httpMethod: "GET")

                    request.start(completionHandler: {(connection, result, error) -> Void in
                    
                    
                        if ((error) != nil){
                            print("Error: \(error)")
                        }
                        else {
                            let data: [String:AnyObject] = result as! [String : AnyObject]
                            
                            

                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let viewC = storyboard.instantiateViewController(withIdentifier: "accountReview") as! AccountReview
                            
                            
                            viewC.FBPassedProf = data
                            
                            
                            self.present(viewC, animated: true, completion: nil)
                        }
                        
                    })

                case .cancelled:
                    print("User cancelled login.")
            }
        }
    }
    
    
    @IBAction func admintouch(_ sender: Any) {
        self.adminTouch += 1
        
        if self.adminTouch >= 3 {
            let storyboard = UIStoryboard.init(name: "Admin", bundle: nil)
            let viewC = storyboard.instantiateViewController(withIdentifier: "welcome")
            
            self.present(viewC, animated: true, completion: nil)
        }
    }
    


}

