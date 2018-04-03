//
//  ReadVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class ReadVC: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var readTextView: UITextView!
    var readDescription: String = ""
    
    //MARK: - override functions
    override func viewDidLoad() {
        super.viewDidLoad()

        readTextView.text = readDescription
    }

}
