//
//  FeedbackVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class FeedbackVC: UIViewController {

    @IBOutlet weak var feedbackTextView: UITextView!
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //Dismiss the keyboard when view is tapped on when in email or password text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        feedbackTextView.resignFirstResponder()
        
    }
    
    //MARK: - Actions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToSettings", sender: self)
    }
    
    @IBAction func submitFeedbackPressed(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "unwindToSettings", sender: self)
    }
    
}
