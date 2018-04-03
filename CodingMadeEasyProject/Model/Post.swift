//
//  Post.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 02/04/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class Post {

    //MARK: - Properties
    var postDescription: String
    var username: String
    var postTitle: String
    var profileImageUrl: String
    
    //MARK: - Initialiser
    init(postDescriptionText: String, usernameText: String, postTitleText: String, profileImageLink: String) {
        postDescription = postDescriptionText
        username = usernameText
        postTitle = postTitleText
        profileImageUrl = profileImageLink
    }
    
}
