//
//  ViewController.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 23/10/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var signInSelector: UISegmentedControl!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
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

    //MARK:Actions
    
    @IBAction func signInSelectorChanged(_ sender: UISegmentedControl) {
        //flip boolean
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
    
    
    
    
    
}

