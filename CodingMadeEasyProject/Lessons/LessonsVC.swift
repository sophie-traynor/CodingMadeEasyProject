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
    
    //MARK: - override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadLessons()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
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
        
        performSegue(withIdentifier: "ShowLesson", sender: self)
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let destination = segue.destination as? IndividualLessonsVC
        let cellIndex = tableView.indexPathForSelectedRow?.row
        
        destination?.lesson = lessons[cellIndex!]
    }
    
    //MARK: - Private Functions
    private func loadLessons(){
        
        //let photo = UIImage(named: "nophoto")
        
        let photoCpp = UIImage(named: "cpp")
        
        guard let lesson1 = Lesson(name: "Lesson 1",
                                   overview: "Learn the structure of a program",
                                   lessonDescription: "description",
                                   readText: "lesson 1 text",
                                   audioName: "lesson1Audio",
                                   videoName: "lesson1Video",
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson1")
        }
        
        guard let lesson2 = Lesson(name: "Lesson 2",
                                   overview: "Variables and data types",
                                   lessonDescription: "description",
                                   readText: "lesson 2 text",
                                   audioName: "lesson2Audio",
                                   videoName: "lesson2Video",
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson2")
        }
        
        guard let lesson3 = Lesson(name: "Lesson 3",
                                   overview: "Print a message to the screen",
                                   lessonDescription: "description",
                                   readText: "lesson 3 text",
                                   audioName: "lesson3Audio",
                                   videoName: "lesson3Video",
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson3")
        }
        
        guard let lesson4 = Lesson(name: "Lesson 4",
                                   overview: "Allow user input in a simple program",
                                   lessonDescription: "description",
                                   readText: "lesson 4 text",
                                   audioName: "lesson4Audio",
                                   videoName: "lesson4Video",
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson4")
        }
        
        guard let lesson5 = Lesson(name: "Lesson 5",
                                   overview: "Arrays",
                                   lessonDescription: "description",
                                   readText: "lesson 5 text",
                                   audioName: "lesson5Audio",
                                   videoName: "lesson5Video",
                                   cellImage: photoCpp)
                                   else {
            fatalError("Unable to instantiate lesson5")
        }
        
        lessons += [lesson1, lesson2, lesson3, lesson4, lesson5]
    }

}
