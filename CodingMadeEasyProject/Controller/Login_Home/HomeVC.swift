//
//  HomeVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 25/10/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

///Store user info for access across views
public struct userInfo{
    static var displayName: String = ""
    static var profileImageUrl: String = ""
    static var firstName: String = ""
    static var lastName: String = ""
    static var email: String = ""
    static var dob: String = ""
    static var coverImageUrl: String = ""
}

class HomeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    var imageTag: Int?
    ///Reference to Firebase Database
    var dataRef: DatabaseReference?
    ///reference to Firebase Storage
    var storageRef: StorageReference?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///Make profile image circular
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        dataRef = Database.database().reference()
        storageRef = Storage.storage().reference()
        loadData()
    }

    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        ///Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        ///Set photoImageView to display the selected image
        if imageTag == 1{
            print("Cover image updated")
            coverImage.image = selectedImage
            saveCoverImage(coverImg: selectedImage)
        }
        else if imageTag == 2{
            print("profile image updated")
            profileImage.image = selectedImage
            saveProfileImage(profileImg: selectedImage)
        }
       
        ///Dismiss the picker
        dismiss(animated:true, completion: nil)
    }
    
    
    //MARK: - Public Functions
    
    func loadData(){
        ///Checks the current users display name from firebase database
        let userID = Auth.auth().currentUser?.uid
        dataRef?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            ///get values from snapshot corresponding to name
            userInfo.displayName = value?["Display Name"] as? String ?? ""
            userInfo.firstName = value?["First Name"] as? String ?? ""
            userInfo.lastName = value?["Last Name"] as? String ?? ""
            userInfo.email = value?["Email"] as? String ?? ""
            userInfo.dob = value?["Date of Birth"] as? String ?? ""
            
            ///set fields to values
            self.displayNameTextField.text = userInfo.displayName
            self.firstNameTextField.text = userInfo.firstName
            self.lastNameTextField.text = userInfo.lastName
            self.emailTextField.text = userInfo.email
            self.dobTextField.text = userInfo.dob
        
            ///check if user has profile image stored
            if snapshot.hasChild("ProfileURL"){
                print ("Profile Image loaded from firebase")
                ///get profile image
                userInfo.profileImageUrl = value?["ProfileURL"] as? String ?? ""
                let profileStorageRef = Storage.storage().reference(forURL: userInfo.profileImageUrl)
                ///Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                profileStorageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print(error)
                    } else {
                        if let imageData = data {
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                self.profileImage.image = image
                            }
                        }
                    }
                }
            }
            else
            {
                print ("Profile Image does not exist")
            }
            ///check if user has cover image stored
            if snapshot.hasChild("CoverURL"){
                print ("Cover Image loaded from firebase")
                ///Get Cover Image
                userInfo.coverImageUrl = value?["CoverURL"] as? String ?? ""
                let coverStorageRef = Storage.storage().reference(forURL: userInfo.coverImageUrl)
                ///Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
                coverStorageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                    if let error = error {
                        print(error)
                    } else {
                        if let imageData = data {
                            DispatchQueue.main.async {
                                let image = UIImage(data: imageData)
                                self.coverImage.image = image
                            }
                        }
                    }
                }
            }
            else
            {
                print ("Cover Image does not exist")
            }
            
            ///if user data isnt stored on firebase, go to complete signup to complete entering data
            if userInfo.displayName == "" || userInfo.firstName == "" || userInfo.lastName == "" || userInfo.dob == "" {
                self.performSegue(withIdentifier: "HomeToCompleteSignup", sender: self)
                print("Missing User Data")
            }
            print("Successfully loaded user data from firebase database")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func saveProfileImage(profileImg: UIImage)
    {
        let userID = Auth.auth().currentUser?.uid
        ///upload profile image to firebase storage
        if let profileImageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            storageRef?.child("profile_images").child(userID!).putData(profileImageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                print("New Profile Image saved to Firebase Storage")
                ///store profile image url in firebase database for user
                let profileURL = metadata?.downloadURL()?.absoluteString
                self.dataRef?.child("users").child(userID!).updateChildValues(["ProfileURL": profileURL!], withCompletionBlock: { (error, ref) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    print("New Profile Image URL saved to Firebase Database")
                })
            })
        }
    }
    
    func saveCoverImage(coverImg: UIImage) {
        let userID = Auth.auth().currentUser?.uid
        ///upload cover image to firebase storage
        if let coverImageData = UIImageJPEGRepresentation(coverImg, 0.1) {
            storageRef?.child("cover_images").child(userID!).putData(coverImageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                print("New Cover Image saved to Firebase Storage")
                ///store cover image url in firebase database for user
                let coverURL = metadata?.downloadURL()?.absoluteString
                self.dataRef?.child("users").child(userID!).updateChildValues(["CoverURL": coverURL!], withCompletionBlock: { (error, ref) in
                    if error != nil{
                        print(error!)
                        return
                    }
                    print("New Cover Image URL saved to Firebase Database")
                })
            })
        }
    }
    
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        ///creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func badge1Tapped(_ sender: UITapGestureRecognizer) {
        createAlert(title: "Achievement #1", message: "Earnt upon completion of C++ Lesson 1!")
    }
    @IBAction func badge2Tapped(_ sender: UITapGestureRecognizer) {
        createAlert(title: "Achievement #2", message: "Earnt upon completion of C++ Lesson 2!")
    }
    @IBAction func badge3Tapped(_ sender: UITapGestureRecognizer) {
        createAlert(title: "Achievement #3", message: "Earnt upon completion of C++ Lesson 3!")
    }
    @IBAction func badge4Tapped(_ sender: UITapGestureRecognizer) {
        createAlert(title: "Achievement #4", message: "Earnt upon completion of C++ Lesson 4!")
    }
    @IBAction func badge5Tapped(_ sender: UITapGestureRecognizer) {
        createAlert(title: "Achievement #5", message: "Earnt upon completion of C++ Lesson 5!")
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        if sender.view?.tag == 1{
            imageTag = 1
        }
        else if sender.view?.tag == 2{
            imageTag = 2
        }
        ///let user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        ///Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}
