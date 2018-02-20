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

class HomeVC: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    
    
    ///Reference to Firebase Database
    var ref: DatabaseReference?
    ///Default name for the user Display Name
    var displayName: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var dob: String = ""
    
    //MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
        ref = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //TODO: - FIX ERROR HANDLING WHEN LOGGING OUT AFTER RELOGGING IN WITH NO DATA
        loadData()
    }
    
    //MARK: - Public Functions
    
    ///Checks the current users display name from firebase database
    func loadData(){
        let userID = Auth.auth().currentUser?.uid
        ref?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
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
            
            if self.displayName == "" || self.firstName == "" || self.lastName == "" || self.dob == "" {
                self.performSegue(withIdentifier: "HomeToCompleteSignup", sender: self)
                print("........no data.......")
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
