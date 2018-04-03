//
//  WatchVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class WatchVC: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var videoThumbnail: UIImageView!
    var videoName: String = ""
    var playerView = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    //MARK: - override functions
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    //MARK: - Actions
    @IBAction func playVideoPressed(_ sender: UIButton) {
        let fileURL = Bundle.main.path(forResource: videoName, ofType: "mp4")
        
        playerView = AVPlayer(url: NSURL(fileURLWithPath: fileURL!) as URL)
        
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true)
    }
    
    
}
