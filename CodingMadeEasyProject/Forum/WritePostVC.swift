//
//  WritePostVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 25/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class WritePostVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: Actions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToForum", sender: self)
    }
}
