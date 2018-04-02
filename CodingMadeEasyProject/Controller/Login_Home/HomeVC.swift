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
    
    ///Default name for the user Display Name
    var displayName: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var dob: String = ""
    var profileImageUrl: String = ""
    var coverImageUrl: String = ""
    
    //MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        dataRef = Database.database().reference()
        storageRef = Storage.storage().reference()
        loadData()
    }
    
   /* override func viewDidAppear(_ animated: Bool) {
        //TODO: - FIX ERROR HANDLING WHEN LOGGING OUT AFTER RELOGGING IN WITH NO DATA
        //loadData()
    }*/
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker if the user cancelled
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //The info dictionary may contain multiple representations of the image
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //Set photoImageView to display the selected image
        
        if imageTag == 1{
            coverImage.image = selectedImage
            saveCoverImage(coverImg: selectedImage)
        }
        else if imageTag == 2{
            profileImage.image = selectedImage
            saveProfileImage(profileImg: selectedImage)
    
        }
       
        //Dismiss the picker
        dismiss(animated:true, completion: nil)
    }
    
    
    //MARK: - Public Functions
    
    ///Checks the current users display name from firebase database
    func loadData(){
        let userID = Auth.auth().currentUser?.uid
        dataRef?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            self.displayName = value?["Display Name"] as? String ?? ""
            self.firstName = value?["First Name"] as? String ?? ""
            self.lastName = value?["Last Name"] as? String ?? ""
            self.email = value?["Email"] as? String ?? ""
            self.dob = value?["Date of Birth"] as? String ?? ""
            
            self.displayNameTextField.text = self.displayName
            self.firstNameTextField.text = self.firstName
            self.lastNameTextField.text = self.lastName
            self.emailTextField.text = self.email
            self.dobTextField.text = self.dob
        
            if snapshot.hasChild("ProfileURL"){
                print ("Profile Image exists")
                self.profileImageUrl = value?["ProfileURL"] as? String ?? ""
                let profileStorageRef = Storage.storage().reference(forURL: self.profileImageUrl)
                /// Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
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
            
            if snapshot.hasChild("ProfileURL"){
                print ("Profile Image exists")
                ///Get Cover Image
                self.coverImageUrl = value?["CoverURL"] as? String ?? ""
                let coverStorageRef = Storage.storage().reference(forURL: self.coverImageUrl)
                /// Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
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
            
            
            if self.displayName == "" || self.firstName == "" || self.lastName == "" || self.dob == "" {
                self.performSegue(withIdentifier: "HomeToCompleteSignup", sender: self)
                print("........no data.......")
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func saveProfileImage(profileImg: UIImage)
    {
        let userID = Auth.auth().currentUser?.uid
        if let profileImageData = UIImageJPEGRepresentation(profileImg, 0.1) {
            storageRef?.child("profile_images").child(userID!).putData(profileImageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                let profileURL = metadata?.downloadURL()?.absoluteString
                self.dataRef?.child("users").child(userID!).updateChildValues(["ProfileURL": profileURL!], withCompletionBlock: { (error, ref) in
                    if error != nil{
                        print(error!)
                        return
                    }
                })
            })
        }
    }
    
    func saveCoverImage(coverImg: UIImage) {
        let userID = Auth.auth().currentUser?.uid
        if let coverImageData = UIImageJPEGRepresentation(coverImg, 0.1) {
            storageRef?.child("cover_images").child(userID!).putData(coverImageData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                let coverURL = metadata?.downloadURL()?.absoluteString
                self.dataRef?.child("users").child(userID!).updateChildValues(["CoverURL": coverURL!], withCompletionBlock: { (error, ref) in
                    if error != nil{
                        print(error!)
                        return
                    }
                })
            })
        }
    }
    
    //MARK: - Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        if sender.view?.tag == 1{
            imageTag = 1
        }
        else if sender.view?.tag == 2{
            imageTag = 2
        }
        
        //UIImagePickerController is a view controller that lets a user pick media from their photo library
        let imagePickerController = UIImagePickerController()
        
        //Only allow photos to be picked, not taken
        imagePickerController.sourceType = .photoLibrary
        
        //Make sure ViewController is notified when the user picks an image
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}