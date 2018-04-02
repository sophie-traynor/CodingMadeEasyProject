//
//  DoVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class DoVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var codeTextView: UITextView!
   
    var answer: String = ""
    var output: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    //Dismiss the keyboard when view is tapped on
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        codeTextView.resignFirstResponder()
    
    }
    
    @IBAction func helpBtnTapped(_ sender: UIButton) {
        createAlert(title: "Help", message: answer)
    }
    
    @IBAction func compileBtnTapped(_ sender: UIButton) {
        let userAnswer: String = codeTextView.text
        
        if userAnswer == answer {
            createAlert(title: "Correct!", message: output)
        }
        else {
            createAlert(title: "Incorrect", message: """
                                                        Try again
                                                        Please ensure correct spacing, quotations and semi colons are included.
                                                        """)
        }
    }
    
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        //creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
}
