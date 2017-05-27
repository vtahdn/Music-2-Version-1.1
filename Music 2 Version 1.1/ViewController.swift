//
//  ViewController.swift
//  Music Version 1.0
//
//  Created by Viet Anh Doan on 5/25/17.
//  Copyright © 2017 Viet. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    var audio = AVAudioPlayer()
    var flag = false
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var durationSlider: UISlider!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        audio = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: ".mp3")!))
        audio.prepareToPlay()
        audio.delegate = self
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(initData), userInfo: nil, repeats: true)
        durationSlider.setThumbImage(UIImage(named: "duration.png"), for: .normal)
    }
    
    func initData() {
        currentTimeLabel.text = String(format: "%2.0f", audio.currentTime/60) + ":" + String(format: "%02d", Int(audio.currentTime) % 60)
        timeLeftLabel.text = String(format: "%2.0f", (audio.duration - audio.currentTime)/60) + ":" + String(format: "%02d", Int(audio.duration - audio.currentTime) % 60)
        durationSlider.value = Float(audio.currentTime/audio.duration)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func volumeSlider(_ sender: UISlider) {
        audio.volume = sender.value
        sender.setThumbImage(UIImage(named: "thumb.png"), for: .normal)
        sender.setThumbImage(UIImage(named: "thumbHightLight.png"), for: .highlighted)
    }
    
    @IBAction func playButtonAction(_ sender: UIButton) {
        if !flag {
            audio.play()
            sender.setImage(UIImage(named: "pause.png"), for: .normal)
            flag = true
        }
        else {
            audio.pause()
            sender.setImage(UIImage(named: "play.png"), for: .normal)
            flag = false
        }
    }
    
    @IBAction func durationSliderAction(_ sender: UISlider) {
        audio.currentTime = Double(sender.value) * audio.duration
    }
    
    @IBAction func repeatSwitchAction(_ sender: UISwitch) {
        audio.numberOfLoops = sender.isOn ? 0 : -1
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if audio.numberOfLoops == 0 {
            playButton.setImage(UIImage(named: "play.png"), for: .normal)
            self.flag = false
        }
    }
}

