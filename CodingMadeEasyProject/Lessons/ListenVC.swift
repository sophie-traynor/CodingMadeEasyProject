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
    @IBOutlet weak var audioDuration: UILabel!
    
    var audioName: String = ""
    var timer: Timer?
    
    var audio = AVAudioPlayer()

    let ncObserver = NotificationCenter.default
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        playAudio()
        audioSlider.value = 0.0
        audioSlider.maximumValue = Float(audio.duration)
        
        audioDuration.text = String(format: "%02d:%02d", ((Int)((audio.duration))) / 60, ((Int)((audio.duration))) % 60)
        
        ncObserver.addObserver(self, selector: #selector(self.stopMusic), name: Notification.Name("StopMusic"), object: nil)
    }
    
    
    @IBAction func audioSliderChanged(_ sender: UISlider) {
        audio.stop()
        audio.currentTime = TimeInterval(audioSlider.value)
        audio.prepareToPlay()
        audio.play()
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        audio.play()
        timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(self.updateSlider), userInfo: nil, repeats: true)
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        if audio.isPlaying {
            audio.pause()
            timer?.invalidate()
        }
    }
    @IBAction func restartPressed(_ sender: UIButton) {
        audio.stop()
        audioSlider.value = 0.0
        audio.currentTime = 0
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
    
    @objc func stopMusic(){
        audio.stop()
    }
    
    @objc func updateSlider(){
        audioSlider.value = Float(audio.currentTime)
    }

}
