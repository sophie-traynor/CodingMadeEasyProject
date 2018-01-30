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
    var audioImage: UIImage?
    var videoName: String
    var videoThumbnail: UIImage?
    var cellImage: UIImage?
    
    //MARK: - Property Key
    struct PropertyKey{
        static let name = "name"
        static let overview = "overview"
        static let lessonDescription = "lessonDescription"
        static let readText = "readText"
        static let audioName = "audioName"
        static let audioImage = "audioImage"
        static let videoName = "videoName"
        static let videoThumbnail = "videoThumbnail"
        static let cellImage = "cellImage"
    }
    
    //MARK: - Initialiser
    init?(name: String, overview: String, lessonDescription: String, readText: String, audioName: String, audioImage: UIImage?, videoName: String, videoThumbnail: UIImage?, cellImage: UIImage?) {
        self.name = name
        self.overview = overview
        self.lessonDescription = lessonDescription
        self.readText = readText
        self.audioName = audioName
        self.audioImage = audioImage
        self.videoName = videoName
        self.videoThumbnail = videoThumbnail
        self.cellImage = cellImage
    }
}

