//
//  ViewController.swift
//  Messaging
//
//  Created by Aravind Subramanian on 11/10/17.
//  Copyright © 2017 Aravind Subramanian. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class LoginVC: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var userUid: String!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func SignIn (_ sender: AnyObject) {
    
        if let email = emailField.text, let password = passwordfield.text{
            
            FIRAuth.auth()?.signIn(with: email,password: password, completion:
                {(user, error) in
                    
                    if error == nil {
                        
                        self.userUid = user?.userUid
                        
                        KeychainWrapper.standard.set(self.userUid, forKey: "uid")
                        
                        performSegue(withIdentifier: "toMessages", sender: nil)
                    
                    } else {
                        
                        performSegue(withIdentifier:"toSignUp", sender: nil)
                    }
                    
            })
        }
    }

}
