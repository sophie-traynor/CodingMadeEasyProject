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

    
    @IBOutlet weak var audioImage: UIImageView!
    @IBOutlet weak var audioSlider: UISlider!
    
    var audioName: String = ""
    var audioImg: UIImage?
    
    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        audioImage.image = audioImg
        
        //var timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: Selector("updateSlider"), userInfo: nil, repeats: true)
        playAudio()
        audioSlider.maximumValue = Float(audio.duration)

    }
    
    
    @IBAction func audioSliderChanged(_ sender: UISlider) {
        audio.stop()
        audio.currentTime = TimeInterval(audioSlider.value)
        audio.prepareToPlay()
        audio.play()
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        audio.play()
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        if audio.isPlaying {
            audio.pause()
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
    
    func playAudio(){
         do {
            audio = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: audioName, ofType: "mp3")!))
            audio.prepareToPlay()
         }
         catch{
            print(error)
         }
    }
    
    func updateSlider(){
        audioSlider.value = Float(audio.currentTime)
    }

}
