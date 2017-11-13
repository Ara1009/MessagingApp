//
//  SignUpVC.swift
//  Messaging
//
//  Created by Aravind Subramanian on 11/11/17.
//  Copyright © 2017 Aravind Subramanian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImagePick: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    var userUid: String!
    
    var emailField: String!
    
    var passwordField: String!
    
    var imagePicker: UIImagePickerController!
    
    var imageSelected = false
    
    var username: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker = UIImagePickerController()
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: "uid") {
            
            performSegue(withIdentifier: "toMessage", sender: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            self.userImagePick.image = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.userImagePick.image = originalImage
        
        } else {
            
            print("Image wasn't selected")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func setUser(img: String) {
        
        let userData = [
        "username": username!,
        "userImg": img]
        
        KeychainWrapper.standard.set(userUid, forKey: "uid")
        
        let location = Database.database().reference().child("users").child(userUid)
        
        location.setValue(userData)
        
        dismiss(animated: true, completion: nil)
    }
    
    func uploadImg() {
        
        if usernameField.text == nil {
            
            signUpButton.isEnabled = false
        } else {
            
            username = usernameField.text
            signUpButton.isEnabled = true
        }
        
        guard let img = userImagePick.image, imageSelected == true else {
            print("Image needs to be selected")
            return
        }
        
        if let imgData = UIImageJPEGRepresentation(img, 0.2) {
            let imgUid = NSUUID().uuidString
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            Storage.storage().reference().child(imgUid).putData(imgData, metadata:metadata) {
                (metadata, error) in
                
                if error != nil {
                    
                    print("Did not upload image")
                } else {
                    
                    print("uploaded")
                    
                    let downloadURL = metadata?.downloadURL()?.absoluteString
                    
                    if let url = downloadURL {
                        
                        self.setUser(img: url)
                    }
                }
            }
        }
    }
    
    @IBAction func createAccount (_sender: AnyObject) {
        
        Auth.auth().createUser(withEmail: emailField, password: passwordField, completion:{ (user, error) in
            
            if error != nil {
                
                print("User has not been created")
            } else {
                
                if let user = user{
                    self.userUid = user.uid
                }
            }
            
            self.uploadImg()
        })
    }
    
    @IBAction func selectedImgPicked (_ sender: AnyObject) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func GoBack (_ sender: AnyObject) {
        
        dismiss(animated: true, completion: nil)
        
    }
}
