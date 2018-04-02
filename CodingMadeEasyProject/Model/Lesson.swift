//
//  Lesson.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 16/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class Lesson {
    
    //MARK: -  Properties
    var name: String
    var overview: String
    var lessonDescription: String
    var readText: String
    var audioName: String
    var videoName: String
    var cellImage: UIImage?
    var answer: String
    var output: String
    
    //MARK: - Property Key
    struct PropertyKey{
        static let name = "name"
        static let overview = "overview"
        static let lessonDescription = "lessonDescription"
        static let readText = "readText"
        static let audioName = "audioName"
        static let videoName = "videoName"
        static let cellImage = "cellImage"
        static let answer = "answer"
        static let output = "output"
    }
    
    //MARK: - Initialiser
    init?(name: String, overview: String, lessonDescription: String, readText: String, audioName: String, videoName: String, cellImage: UIImage?, answer: String, output: String) {
        self.name = name
        self.overview = overview
        self.lessonDescription = lessonDescription
        self.readText = readText
        self.audioName = audioName
        self.videoName = videoName
        self.cellImage = cellImage
        self.answer = answer
        self.output = output
    }
}

