//
//  ViewController.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 23/10/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
    //variable to check if sign in or register is selected - default sign in so true
    var isSignIn:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set status bar to white
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //sends pop up to screen displaying message
    func createAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
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
                        //perform segue
                        print("signed in")
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
                        //perform segue
                    }
                    else{
                        self.createAlert(title: "Error", message: "User not created, try again")
                    }
                }
            }
        }
    }
    
    
    
    
}

