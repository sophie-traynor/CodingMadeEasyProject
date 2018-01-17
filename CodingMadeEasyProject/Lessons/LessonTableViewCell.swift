//
//  LessonTableViewCell.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 16/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit

class LessonTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var lessonImage: UIImageView!
    @IBOutlet weak var lessonName: UILabel!
    @IBOutlet weak var lessonDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
