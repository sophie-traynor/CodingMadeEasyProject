//
//  DoVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class DoVC: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var codeTextView: UITextView!
    var answer: String = ""
    var output: String = ""
    
    //MARK: - override functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpToolbar()
    }
    
    ///Dismiss the keyboard when view is tapped on
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        codeTextView.resignFirstResponder()
    
    }
    
    //MARK: - private functions
    func setUpToolbar(){
        ///add done toolbar to keyboard
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem
            .done, target: self, action: #selector(self.doneClicked))
        
        toolbar.setItems([doneButton], animated: false)
        
        codeTextView.inputAccessoryView = toolbar
    }
    
    @objc func doneClicked()
    {
        view.endEditing(true)
    }
    
    func createAlert (title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        ///creates button on alert
        alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Actions
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
    
}
