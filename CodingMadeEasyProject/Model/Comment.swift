//
//  Comment.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 03/04/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class Comment{
    
    //MARK: - Properties
    var comment: String
    var username: String
    var profileImage: UIImage?
    
    //MARK: - Initialiser
    init?(commentText: String, usernameText: String, profileImg: UIImage?) {
        comment = commentText
        username = usernameText
        profileImage = profileImg
    }
    
}
