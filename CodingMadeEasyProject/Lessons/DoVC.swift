//
//  DoVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class DoVC: UIViewController {
    
    @IBOutlet weak var codeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Dismiss the keyboard when view is tapped on
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        codeTextView.resignFirstResponder()
    
    }

}
