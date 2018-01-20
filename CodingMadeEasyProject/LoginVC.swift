//
//  ViewController.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 23/10/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class LoginVC: UIViewController, FBSDKLoginButtonDelegate {
    
    //MARK: Properties
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var facebookView: UIView!
    
    //variable to check if sign in or register is selected - default sigs n in so true
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set status bar to white
        UIApplication.shared.statusBarStyle = .lightContent
        
        let fbLoginButton = FBSDKLoginButton()
        facebookView.addSubview(fbLoginButton)
        fbLoginButton.frame = CGRect(x: 0, y: 0, width: facebookView.frame.width, height: facebookView.frame.height)
        
        fbLoginButton.delegate = self
    }
    
    //facebook login
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "loginToHomeScreen", sender: self)
            }
            else{
                self.createAlert(title: "Error", message: "Could not login via Facebook")
            }
        }
        
        print("Successfully logged in with facebook...")
    }
    
    
    //sends pop up to screen displaying message
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //Dismiss the keyboard when view is tapped on
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    //MARK:Actions
    
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
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    //checks if any errors e.g. user not created yet
                    if error == nil{
                        //......................CHECK IF COMPLETE SIGN UP IS COMPLETE
                        self.performSegue(withIdentifier: "loginToHomeScreen", sender: self)
                    }
                    else{
                        self.createAlert(title: "User does not exist", message: "Check details again or register to create user")
                    }
                }
            }
            //create user if register is selected
            else{
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    if error == nil{
                        Auth.auth().signIn(withEmail: email, password: password)
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

