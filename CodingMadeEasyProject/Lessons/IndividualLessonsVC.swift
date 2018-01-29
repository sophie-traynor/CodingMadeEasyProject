//
//  IndividualLessonsVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class IndividualLessonsVC: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var lessonNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var readView: UIView!
    @IBOutlet weak var listenView: UIView!
    @IBOutlet weak var watchView: UIView!
    @IBOutlet weak var doView: UIView!
    
    var lesson: Lesson?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lessonNameLbl.text = lesson?.name
        descriptionLbl.text = lesson?.lessonDescription
        
        readView.isHidden = false
        listenView.isHidden = true
        watchView.isHidden = true
        doView.isHidden = true
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRead"{
            let destination = segue.destination as? ReadVC
            destination?.readDescription = (lesson?.readText)!
            
        }
        else if segue.identifier == "ShowListen"{
            let destination = segue.destination as? ListenVC
            destination?.audioName = (lesson?.audioName)!
            
        }
        else if segue.identifier == "ShowWatch"{
            let destination = segue.destination as? WatchVC
            destination?.videoName = (lesson?.videoName)!
        }
        else if segue.identifier == "ShowDo"{
            //let destination = segue.destination as? DoVC
            
        }
    }
    
    //MARK: - Actions
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToLesson", sender: self)
    }
    
    @IBAction func ShowContainer(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            readView.isHidden = false
            listenView.isHidden = true
            watchView.isHidden = true
            doView.isHidden = true
        case 1:
            readView.isHidden = true
            listenView.isHidden = false
            watchView.isHidden = true
            doView.isHidden = true
        case 2:
            readView.isHidden = true
            listenView.isHidden = true
            watchView.isHidden = false
            doView.isHidden = true
        case 3:
            readView.isHidden = true
            listenView.isHidden = true
            watchView.isHidden = true
            doView.isHidden = false
        default:
            readView.isHidden = false
            listenView.isHidden = true
            watchView.isHidden = true
            doView.isHidden = true
            
        }
    }
}
