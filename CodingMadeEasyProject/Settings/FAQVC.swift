//
//  FAQVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 21/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class FAQVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK: Actions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToSettings", sender: self)
    }
}
