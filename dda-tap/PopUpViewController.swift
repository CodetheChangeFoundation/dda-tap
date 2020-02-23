//
//  PopUpViewController.swift
//  dda-tap
//
//  Created by Shirley Yang on 2020-02-19.
//  Copyright © 2020 Code the Change. All rights reserved.
//

import UIKit
import AVFoundation

class PopUpViewController: UIViewController, AVAudioPlayerDelegate, UIGestureRecognizerDelegate {

    var audioPlayer : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
                let audioURL = Bundle.main.path(forResource: "sampleAudio", ofType: "mp3") // should be m4a file just so there's no gap in the loop
                
                try audioPlayer = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioURL!) as URL)
                audioPlayer?.delegate = self
                audioPlayer?.volume = 10.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // sleep 3 seconds before playing sound
                self.audioPlayer?.play()
            }
                audioPlayer?.numberOfLoops = -1; // looops on repeat
            
        } catch {
            print("error")
            
        }
        
 
 }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
