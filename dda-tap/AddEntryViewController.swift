//
//  AddEntryViewController.swift
//  dda-tap
//
//  Created by Kushagra Sharma on 2019-10-27.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit
import AVFoundation

class AddEntryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    var imagePickerController : UIImagePickerController!
    var stackView: UIStackView!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer?
    var aLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        selectedImageView.image = UIImage(named: "TakePictureImage")
        
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
    }
    
        func startRecording() {
        // right now just ensuring background changes color to show user audio is being recorded
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        // make a record button
        recordButton.setTitle("Tap to Stop", for: .normal)
        
        // 3
        var audioURL = AddEntryViewController.getAudioURL()
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
            let recording = audioRecorder.record(forDuration: 60) // ensures only records for 1 min max.
        } catch {
            finishRecording(success: false)
        }
        
    }
    
    // destroys audioRecorder object and if successful, allows re-recordings
    func finishRecording(success: Bool) {
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
        } else {
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    // depending on current state, will allow recordings – currently not a feature
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
    
    
    //    N/A FOR NOW
    //    func loadRecordingUI() {
    //        recordButton.translatesAutoresizingMaskIntoConstraints = false
    //        recordAudio(recordButton)
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
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        } else { // should be called when 60 seconds is up
            view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // play recording
    @IBAction func playButton(_ sender: UIButton) {
        recordButton.isEnabled = false
        
        audioPlayer?.prepareToPlay()
        audioPlayer = try? AVAudioPlayer(contentsOf: AddEntryViewController.getAudioURL())
        audioPlayer?.delegate = self
        audioPlayer?.volume = 5.0
        audioPlayer?.play()
        recordButton.isEnabled = true;
        playButton.isEnabled = true;
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        playButton.isEnabled = true
    }
    
    // IMAGE FUNCTIONALITY
    @IBOutlet weak var selectedImageView: UIImageView!

    @IBAction func onPhotoButton(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        selectedImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func saveImage(imageName: String){
        let _ = FileManager.default
        //get the image path
        let _ = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = selectedImageView.image!
        let _ = UIImagePNGRepresentation(image)
        //store it in the document directory    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
    }
    
    func getImage(imageName: String){
        let fileManager = FileManager.default
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        if fileManager.fileExists(atPath: imagePath){
            selectedImageView.image = UIImage(contentsOfFile: imagePath)
        }else{
            print("ERROR: Could not find image :(")
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // cmd-shift-k to clean project: will resolve many issues.
}



