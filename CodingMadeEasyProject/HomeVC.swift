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
        
        ref = Database.database().reference()
        loadData()
        
    }
    
    //MARK: - Public Functions
    
    ///Checks the current users display name from firebase database
    func loadData(){
        let userID = Auth.auth().currentUser?.uid
        ref?.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            let displayName = value?["Display Name"] as? String ?? ""
            let firstName = value?["First Name"] as? String ?? ""
            let lastName = value?["Last Name"] as? String ?? ""
            let email = value?["Email"] as? String ?? ""
            let dob = value?["Date of Birth"] as? String ?? ""
            
            self.displayNameTextField.text = displayName
            self.firstNameTextField.text = firstName
            self.lastNameTextField.text = lastName
            self.emailTextField.text = email
            self.dobTextField.text = dob
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}
