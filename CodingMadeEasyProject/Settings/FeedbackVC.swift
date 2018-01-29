//
//  FeedbackVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class FeedbackVC: UIViewController {

    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Actions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToSettings", sender: self)
    }
    
    @IBAction func submitFeedbackPressed(_ sender: UIButton) {
        
        
        self.performSegue(withIdentifier: "unwindToSettings", sender: self)
    }
    
}
