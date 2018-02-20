//
//  LoginVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 23/10/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginVC: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var facebookView: UIView!
    
    ///variable to check if sign in or register is selected
    var isSignIn:Bool = true
    
    //MARK: - override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set status bar to white
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Keep user signed in if not logged out in previous session
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "loginToHomeScreen", sender: self)
        }
    }
    
    //Dismiss the keyboard when view is tapped on when in email or password text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //MARK: - Navigation
    
    //Carries out code before segue is initiated
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //sends the email address to a text field on CompleteSignupVC if that particular segue is initiated
        if let vc = segue.destination as? CompleteSignupVC
        {
            vc.emailAddress = emailTextField.text!
        }
    }
    
    //MARK: - Public Functions
    
    ///sends pop up to screen displaying message
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        //flip boolean - switch to sign in or register
        isSignIn = !isSignIn
        
        //check bool and set buttons and labels
        if isSignIn {
            signInLabel.text = "Sign In"
            signInBtn.setTitle("Sign In", for: .normal)
        }
        else{
            signInLabel.text = "Register"
            signInBtn.setTitle("Register", for: .normal)
        }
    }
    
    @IBAction func signInBtnTapped(_ sender: UIButton) {
        //store values in email and password fields
        if let email = emailTextField.text, let password = passwordTextField.text{
            
            //sign user in if selector is on sign in
            if isSignIn {
                
                //Calls the sign in method using the email and password provided by user
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    
                    //checks if any errors e.g. user not created yet
                    if error == nil{
                        
                        //TODO: - CHECK IF COMPLETE SIGN UP IS COMPLETE
                       //go to home screen if user has been authenticated
                        self.performSegue(withIdentifier: "loginToHomeScreen", sender: self)
                    }
                    else{
                        self.createAlert(title: "User does not exist", message: "Check details again or register to create user")
                    }
                }
            }
            //create user if register is selected
            else{
                //Calls the create user method to add a new user to the firebase database
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    if error == nil{
                        
                        //Sign user in with created details if user has been created successfully
                        Auth.auth().signIn(withEmail: email, password: password)
                        
                        //go to complete signup screen to get further details about new user
                        self.performSegue(withIdentifier: "loginToCompleteSignupScreen", sender: self)
                    }
                    else{
                        self.createAlert(title: "Error", message: "User not created")
                    }
                }
            }
        }
    }
}

