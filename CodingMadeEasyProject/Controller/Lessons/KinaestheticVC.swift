//
//  KinaestheticVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 17/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class KinaestheticVC: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var lessonDescription: UILabel!
    @IBOutlet weak var lessonNameLabel: UILabel!
    
    var lesson: Lesson?
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonNameLabel.text = lesson?.name
        lessonDescription.text = lesson?.kinaestheticDescription
    }
    
    //MARK: Actions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToLesson", sender: self)
    }
    
}

