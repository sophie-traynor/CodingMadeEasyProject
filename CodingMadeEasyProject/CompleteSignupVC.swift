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

class CompleteSignupVC: UIViewController, UITextFieldDelegate {

    //MARK: - Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    let datePicker = UIDatePicker()
    
    ///String to store the email address retrieved from the LoginVC 
    //var emailAddress: String?
    
    ///Reference to Firebase Database
    var ref: DatabaseReference?
    
    //MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayNameTextField.delegate = self
        emailTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        dateOfBirthTextField.delegate = self
        
        createDatePicker()
        
        ref = Database.database().reference()
        
        ///load email
        let user = Auth.auth().currentUser
        let email = user?.email
        emailTextField.text = email
        
    }


    //MARK: - Text Field Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag
        {
        case 0:
            scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        case 1:
            scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        case 2:
            scrollView.setContentOffset(CGPoint(x:0,y:50), animated: true)
        case 3:
            scrollView.setContentOffset(CGPoint(x:0,y:120), animated: true)
        case 4:
            scrollView.setContentOffset(CGPoint(x:0,y:150), animated: true)
        default:
            scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            displayNameTextField.resignFirstResponder()
        }
        else if textField.tag == 1 {
            emailTextField.resignFirstResponder()
        }
        else if textField.tag == 2 {
            firstNameTextField.resignFirstResponder()
        }
        else if textField.tag == 3 {
            lastNameTextField.resignFirstResponder()
        }
        else if textField.tag == 4 {
            dateOfBirthTextField.resignFirstResponder()
        }
        return true
    }
    
    //MARK: - Actions
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        //dismiss home view controller
        self.performSegue(withIdentifier: "unwindToLogin", sender: self)
    }
    
    
    @IBAction func completeBtnClicked(_ sender: Any) {
        
        if firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || dateOfBirthTextField.text!.isEmpty{
            createAlert(title: "Error", message: "All Fields must contain values")
        }
        else{
            saveData()
            //TODO: - fix dismissing of complete signup
            self.dismiss(animated: true, completion: {});
            self.performSegue(withIdentifier: "completeSignupToHomeScreen", sender: self)
        }
    }
    
    //MARK: - Public Functions
    
    func createDatePicker()
    {
        ///create toolbar for date picker view to hold done button
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        dateOfBirthTextField.inputAccessoryView = toolbar
        dateOfBirthTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
    }
    
    @objc func donePressed()
    {
        ///format date in picker
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: datePicker.date)
        
        dateOfBirthTextField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    ///sends pop up to screen displaying a message
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    ///Gets values from entered fields and uploads them to firebase database
    func saveData(){
        
        let displayName = displayNameTextField.text
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let dateOfBirth = dateOfBirthTextField.text
        self.ref?.child("users").child((Auth.auth().currentUser?.uid)!).updateChildValues(["Display Name" : displayName!, "First Name" : firstName!, "Last Name": lastName!, "Date of Birth": dateOfBirth!], withCompletionBlock: { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
        })
    }
}
