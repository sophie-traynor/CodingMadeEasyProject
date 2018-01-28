//
//  LessonsVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 28/12/2017.
//  Copyright © 2017 Sophie Traynor. All rights reserved.
//

import UIKit

class LessonsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var lessons = [Lesson]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLessons()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Actions
    @IBAction func unwindToLessons(segue: UIStoryboardSegue) {
        
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LessonTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LessonTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LessonTableViewCell.")
        }
        
        //Fetches the appropriate lesson for the data source layout.
        let lesson = lessons[indexPath.row]
        
        cell.lessonName.text = lesson.name
        cell.lessonOverview.text = lesson.overview
        cell.lessonImage.image = lesson.cellImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "ShowVisual", sender: self)
        case 1:
            performSegue(withIdentifier: "ShowAuditory", sender: self)
        case 2:
            performSegue(withIdentifier: "ShowReadWrite", sender: self)
        case 3:
            performSegue(withIdentifier: "ShowKinaesthetic", sender: self)
        default:
            fatalError("Unexpected Segue Identifier")
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowVisual":
            let destination = segue.destination as? VisualVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        case "ShowAuditory":
            let destination = segue.destination as? AuditoryVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        case "ShowReadWrite":
            let destination = segue.destination as? ReadWriteVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        case "ShowKinaesthetic":
            let destination = segue.destination as? KinaestheticVC
            let cellIndex = tableView.indexPathForSelectedRow?.row
            
            destination?.lesson = lessons[cellIndex!]
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: - Private Functions
    private func loadLessons(){
        
        //let photo = UIImage(named: "nophoto")
        
        let photoCpp = UIImage(named: "cpp")
        let auditoryL1 = UIImage(named: "lesson1auditory")
        let auditoryL2 = UIImage(named: "lesson2auditory")
        let auditoryL3 = UIImage(named: "lesson3auditory")
        let auditoryL4 = UIImage(named: "lesson4auditory")
        let auditoryL5 = UIImage(named: "lesson5auditory")
        
        guard let lesson1 = Lesson(name: "Lesson 1",
                                   overview: "Learn the structure of a program",
                                   visualDescription: "Watch the video below to learn about the structure of a C++ program",
                                   auditoryDescription: "Listen to the audio below to learn about the structure of a C++ Program",
                                   readWriteDescription: "lesson 1 readWrite description",
                                   kinaestheticDescription: "lesson 1 kinaesthetic description",
                                   cellImage: photoCpp,
                                   auditoryImage: auditoryL1) else {
            fatalError("Unable to instantiate lesson1")
        }
        
        guard let lesson2 = Lesson(name: "Lesson 2",
                                   overview: "Variables and data types",
                                   visualDescription: "Watch the video below to learn about variabels and the different data types they can store",
                                   auditoryDescription: "Listen to the audio below to learn about what a variable is and the different types of values it can hold",
                                   readWriteDescription: "A variable can be described as a type of storage. Variables can have different types which will affect the value it can hold. There are many different types of variables. We will focus on the main ones you will come across.Examples of variables include, int, float, bool, and char. An int, variable is short for integer which means it can store whole numbers. A float variable can store numerical values with a decimal point. A bool variable can store either a true or false value.  A char variable can store one character, this can be a letter or a number etc.",
                                   kinaestheticDescription: "lesson 2 kinaesthetic description",
                                   cellImage: photoCpp,
                                   auditoryImage: auditoryL2) else {
            fatalError("Unable to instantiate lesson2")
        }
        
        guard let lesson3 = Lesson(name: "Lesson 3",
                                   overview: "Print a message to the screen",
                                   visualDescription: "Watch the video below to learn about how you can print a message to the screen",
                                   auditoryDescription: "Listen to the audio below to learn how to print a message to the screen",
                                   readWriteDescription: "lesson 3 readWrite description",
                                   kinaestheticDescription: "lesson 3 kinaesthetic description",
                                   cellImage: photoCpp,
                                   auditoryImage: auditoryL3) else {
            fatalError("Unable to instantiate lesson3")
        }
        
        guard let lesson4 = Lesson(name: "Lesson 4",
                                   overview: "Allow user input in a simple program",
                                   visualDescription: "Watch the video below to learn about how to ask a user to input something into the program",
                                   auditoryDescription: "Listen to the audio below to learn how to ask for user input to a program",
                                   readWriteDescription: "lesson 4 readWrite description",
                                   kinaestheticDescription: "lesson 4 kinaesthetic description",
                                   cellImage: photoCpp,
                                   auditoryImage: auditoryL4) else {
            fatalError("Unable to instantiate lesson4")
        }
        
        guard let lesson5 = Lesson(name: "Lesson 5",
                                   overview: "Arrays",
                                   visualDescription: "Watch the video below to learn about what arrays are and how to use them",
                                   auditoryDescription: "Listen to the audio below to learn about what arrays are and how to use them",
                                   readWriteDescription: "lesson 5 readWrite description",
                                   kinaestheticDescription: "lesson 5 kinaesthetic description",
                                   cellImage: photoCpp,
                                   auditoryImage: auditoryL5) else {
            fatalError("Unable to instantiate lesson5")
        }
        
        lessons += [lesson1, lesson2, lesson3, lesson4, lesson5]
    }

}
