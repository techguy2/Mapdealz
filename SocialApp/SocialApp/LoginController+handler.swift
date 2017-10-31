//
//  LoginController+handler.swift
//  SocialApp
//
//  Created by Soeb on 8/17/17.
//  Copyright © 2017 soeb. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func handleRegister() {
        if loginRegisterButton.currentTitle == "Register" {
            guard let email = containerView.emailText.text, let password = containerView.passwordText.text, let name = containerView.nameText.text else {
                print("Form is not completed")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error!)
                    return
                }
                // Generate random string
                let imageName = UUID().uuidString
                //Successfully authenticated the user
                let storageRef = Storage.storage().reference().child("\(imageName).jpg")
                if let uploadData = UIImageJPEGRepresentation(self.profileImageView.image!, 0.5) {
                    
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        
                        if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                            let values = ["name":name, "email":email, "profileImageUrl":profileImageUrl]
                            
                            self.registerUserIntoDatabaseWithUID(uid: (user?.uid)!, values: values)

                        }

                    })

                }
                
            }
        }
            
        else {
            handleLogin()
        }
        
        
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String:Any]) {
        
        let ref = Database.database().reference(fromURL: "https://socialapp-2d499.firebaseio.com")
        let userReference = ref.child("users").child(uid)
        userReference.updateChildValues(values
            , withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error!)
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
                
        })

    }
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?

        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        dismiss(animated: true, completion: nil)
        if let selectImage = selectedImageFromPicker {
            profileImageView.image = selectImage
            
        }
    }
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
