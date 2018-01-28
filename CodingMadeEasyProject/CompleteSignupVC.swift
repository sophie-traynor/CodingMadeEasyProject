//
//  CompleteSignupVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CompleteSignupVC: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    var emailAddress: String = ""
    var ref: DatabaseReference?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        emailTextField.text = emailAddress
    }
    
    //MARK: - Actions
    @IBAction func completeBtnClicked(_ sender: Any) {
        
        if firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || dateOfBirthTextField.text!.isEmpty{
            createAlert(title: "Error", message: "All Fields must contain values")
        }
        else{
            saveData()
            self.performSegue(withIdentifier: "completeSignupToHomeScreen", sender: self)
        }
    }
    
    //MARK: - Public Functions
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveData(){
        
        let email = emailTextField.text
        let displayName = displayNameTextField.text
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let dateOfBirth = dateOfBirthTextField.text
        self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["Email" : email!, "Display Name" : displayName!, "First Name" : firstName!, "Last Name": lastName!, "Date of Birth": dateOfBirth!], withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
        })
    }
}
