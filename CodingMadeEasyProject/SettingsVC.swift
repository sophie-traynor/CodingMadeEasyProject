//
//  SettingsVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class SettingsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: Actions
    
    @IBAction func contactBtnPressed(_ sender: UIButton) {
        createAlert(title: "Contact Details", message: "Email: email@email.com")
        
    }
    
    @IBAction func SignOut (_sender: Any){
        let firebaseAuth = Auth.auth()
        let loginManager = FBSDKLoginManager()
        
        if FBSDKAccessToken.current() == nil {
            loginManager.logOut()
        } else {
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        
        //dismiss home view controller
        self.dismiss(animated: true, completion: {});
        self.navigationController?.popViewController(animated: true);
    }

    
    //MARK: functions
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
    
        self.present(alert, animated: true, completion: nil)
    }
}
