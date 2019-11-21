//
//  AudioRecordingControllerViewController.swift
//  dda-tap
//
//  Created by Shirley Yang on 2019-10-26.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit
import AVFoundation

class AudioRecordingViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate  {
    
    var stackView: UIStackView!
    //var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer?
    var aLabel: UILabel!
    @IBOutlet weak var playButton: UIButton! // play button
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aLabel = UILabel()
        aLabel.text = "Failed to load!"
        aLabel.font = UIFont.systemFont(ofSize: 36)
        aLabel.sizeToFit()
        aLabel.center = CGPoint(x: 100, y: 40)
        view.addSubview(aLabel)
        
        // initial background is green: when recording, turns red
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        recordingSession = AVAudioSession.sharedInstance()
        // https://stackoverflow.com/questions/27423243/swift-avaudioplayer-wont-play-audio-recorded-with-avaudiorecorder
        do{
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord) // PlayandRecord
        }catch{
            
        }
        
        // requests user's  permission to record audio
        do {
            //try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
//        if (!audioRecorder.isRecording) {
//            finishRecording(success: true)
//        }
    }
    
    func startRecording() {
        // may change, right now just ensuring background changes color to show user audio is being recorded
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        // make a record button
        recordButton.setTitle("Tap to Stop", for: .normal)
        
        // 3
        var audioURL = AudioRecordingViewController.getAudioURL()
        print(audioURL.absoluteString)
        
        // 4
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            // 5
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record(forDuration: 60) // ensures only records for 1 min max.
//            if (!audioRecorder.isRecording) {
//                view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
//            }
        } catch {
            finishRecording(success: false)
        }
//                if (!audioRecorder.isRecording) {
//                    finishRecording(success: true)
//                }
        
        //finishRecording(success: true)
    }
    
    // destroys audioRecorder object and if successful, allows re-recordings
    func finishRecording(success: Bool) {
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            //recordButton.setTitle("Tap to Re-record", for: .normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        } else {
            //recordButton.setTitle("Tap to Record", for: .normal)
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

    
    // depending on current state, will allow recordings
    @objc func nextTapped() {

    }
    
    @IBAction func recordAudio(_ sender: UIButton) {
        recordTapped()
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
//    @objc func playTapped() {
//
//            startPlaying()
//
//    }
    
    //commented out
    func loadRecordingUI() {
        //recordButton = UIButton()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        //recordButton.setTitle("Tap to Record", for: .normal)
        //recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        recordAudio(recordButton)
        //recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        //playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        //stackView.addArrangedSubview(recordButton)
    }
    
    //added
//    func startPlaying() {
//        //var error: NSError?
//
//        var audioURL = AudioRecordingViewController.getAudioURL()
//        let player = try? AVAudioPlayer(contentsOf: audioURL)
//        player?.prepareToPlay()
//        player?.play()
//
//    }

    
    // if audio recording fails
    func loadFailUI() {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording failed: ensure the app has access to your microphone."
        failLabel.numberOfLines = 0
        
        stackView.addArrangedSubview(failLabel)
    }
    
    // stores audio in writable directory in app
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getAudioURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent("audio.m4a")
    }
    
    //
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // play recording
    @IBAction func playButton(_ sender: UIButton) {
//        if audioRecorder?.isRecording == false{
            recordButton.isEnabled = false
            
            //var error : NSError?
            
            audioPlayer?.prepareToPlay()
            audioPlayer = try? AVAudioPlayer(contentsOf: AudioRecordingViewController.getAudioURL())
            audioPlayer?.delegate = self
            audioPlayer?.volume = 5.0
            audioPlayer?.play()
            recordButton.isEnabled = true;
            playButton.isEnabled = true;
//            if let err = error{
//            } else{
//                print("good")
//                audioPlayer?.play()
//
//            }
//        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.isEnabled = true
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
