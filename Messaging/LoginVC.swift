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

    override func viewDidAppear(_ _animated: Bool) {
        
        
        if let _ = KeychainWrapper.standard.string(forKey: "uid"){
            
            performSegue(withIdentifier: "toMessages", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        if segue.identifier == "toSignUp" {
            
            if let destination = segue.destination as? SignUpVC {
                
                if self.userUid != nil{
                    
                    destination.userUid = userUid
                }
                
                if self.emailField.text != nil {
                    
                    destination.emailField = emailField.text
                }
                
                if self.passwordField.text != nil {
                    
                    destination.passwordField =  passwordField.text
                }
            }
        }
    }
    @IBAction func SignIn (_ sender: Any) {
    
        if let email = emailField.text, let password = passwordField.text{
            
            Auth.auth().signIn(withEmail: email, password: password, completion:
                {(user, error) in
                    
                if error == nil {
                    

                    KeychainWrapper.standard.set(self.userUid, forKey: "uid")
                    
                    self.performSegue(withIdentifier: "toMessage", sender: nil)
                    
                } else {
                        
                        self.performSegue(withIdentifier:"toSignUp", sender: nil)
                    }
                    
            })
        }
    }

}
