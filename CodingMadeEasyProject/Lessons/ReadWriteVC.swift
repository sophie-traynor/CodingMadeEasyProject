//
//  ReadWriteVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 17/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class ReadWriteVC: UIViewController {
    
    var lesson: Lesson?
    
    @IBOutlet weak var lessonDescription: UILabel!
    @IBOutlet weak var lessonNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonNameLabel.text = lesson?.name
        lessonDescription.text = lesson?.readWriteDescription
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToLesson", sender: self)
    }

}
