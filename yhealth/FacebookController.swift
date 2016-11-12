//
//  ViewController.swift
//  yhealth
//
//  Created by Jessica Joseph on 11/11/16.
//  Copyright © 2016 Jessica Joseph. All rights reserved.
//

import UIKit
import FacebookLogin

class FacebookController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookLogin(_ sender: AnyObject) {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
                case .failed(let error):
                    print(error)
                case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                    print("Logged in!")
                    print(grantedPermissions)
                    print(declinedPermissions)
                    print(accessToken)
                    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                    let viewC = storyboard.instantiateViewController(withIdentifier: "insure")
                    self.present(viewC, animated: true, completion: nil)
                case .cancelled:
                    print("User cancelled login.")
            }
        }
    }


}

