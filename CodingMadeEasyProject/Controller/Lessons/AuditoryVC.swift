//
//  AuditoryVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 17/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit
import AVFoundation

class AuditoryVC: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var lessonDescription: UITextView!
    @IBOutlet weak var lessonNameLabel: UILabel!
    @IBOutlet weak var auditoryImage: UIImageView!
    
    var lesson: Lesson?
    var lessonAudio: AVAudioPlayer?
    
    //MARK: override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lessonNameLabel.text = lesson?.name
        lessonDescription.text = lesson?.auditoryDescription
        auditoryImage.image = lesson?.auditoryImage
    }
    
    //MARK: - Actions
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToLesson", sender: self)
    }
    
    //MARK: Public Functions
    func playMusic(name : String){
        let path = Bundle.main.path(forResource: name, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            lessonAudio = try AVAudioPlayer(contentsOf: url)
            lessonAudio?.play()
        } catch {
            //couldn't load file
        }
    }
}
