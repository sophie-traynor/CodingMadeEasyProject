//
//  ListenVC.swift
//  CodingMadeEasyProject
//
//  Created by Sophie Traynor on 29/01/2018.
//  Copyright © 2018 Sophie Traynor. All rights reserved.
//

import UIKit
import AVFoundation

class ListenVC: UIViewController {

    var audioName: String = ""
    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /*do {
            audio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: lesson?.audioName, ofType: "mp3")!))
            audio.prepareToPlay()
        }
        catch{
            print(error)
        }*/
    }

    @IBAction func playPressed(_ sender: UIButton) {
        audio.play()
        
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        if audio.isPlaying {
            audio.pause()
        }
        else{
            
        }
    }
    @IBAction func restartPressed(_ sender: UIButton) {
        if audio.isPlaying {
            audio.currentTime = 0
            audio.play()
        }
        else {
            audio.play()
        }
    }

}
