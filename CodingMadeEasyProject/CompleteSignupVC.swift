//
//  CompleteSignupVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CompleteSignupVC: UIViewController {

    //MARK: Properties
    let databaseReference = Database.database().reference(fromURL: "https://codingmadeeasy-8e2db.firebaseio.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: Actions
    @IBAction func completeBtnClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "completeSignupToHomeScreen", sender: self)
    }
    

}
