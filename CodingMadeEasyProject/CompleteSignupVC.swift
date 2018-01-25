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

    //MARK: Properties
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    
    
    let databaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: Actions
    @IBAction func completeBtnClicked(_ sender: Any) {
        
        if firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || dateOfBirthTextField.text!.isEmpty{
            createAlert(title: "Error", message: "All Fields must contain values")
        }
        else{
            self.performSegue(withIdentifier: "completeSignupToHomeScreen", sender: self)
        }
    }
    
    //MARK: functions
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func saveData(){
        
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let dateOfBirth = dateOfBirthTextField.text
        
        self.databaseReference.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["firstName" : firstName!, "lastName": lastName!, "dateOfBirth": dateOfBirth!], withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
        })
    }
}
