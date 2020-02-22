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
    
    var cameraImagePickerController : UIImagePickerController!
    var source : String!
    var selectedImage : UIImage!
    var imagePickerController : UIImagePickerController!
    var stackView: UIStackView!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer : AVAudioPlayer?
    var aLabel: UILabel!
    var audioExists: Bool!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    enum AddEntryError : Error {
        case noCameraInSimulator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let img: UIImage = UIImage(named: "TakePictureImage")
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        selectedImageView.image = UIImage(named: "TakePictureImage")
        cameraImagePickerController = UIImagePickerController()
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
        
        audioExists = false
    }
    
        func startRecording() {
        // may change, right now just ensuring background changes color to show user audio is being recorded
        view.backgroundColor = UIColor(red: 0, green: 0.6, blue: 0, alpha: 1)
        
        // make a record button
        recordButton.setTitle("Tap to Stop", for: .normal)
        
        // 3
        var audioURL = AddEntryViewController.getAudioURL()
        //print(audioURL.absoluteString)
        
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
    
    @IBAction func onSaveEntryButton(_ sender: Any) {
//        var temp : AVAudioPlayer?
//        var audioClipExists = true
//        do {
//        temp = try AVAudioPlayer(contentsOf: AddEntryViewController.getAudioURL())
//        } catch {
//            audioClipExists = false
//        }
        
        if (selectedImage == nil && audioExists) {
            let alert = UIAlertController(title: "No image selected", message: "You need to select an image before you can save!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if (selectedImage == nil && !audioExists) {
            let alert = UIAlertController(title: "No image or audio clip selected", message: "You need to select an image and audio clip before you can save!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else if (selectedImage != nil && !audioExists) {
            let alert = UIAlertController(title: "No audio clip selected", message: "You need to select an audio clip before you can save!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        
    }

    
    // destroys audioRecorder object and if successful, allows re-recordings
    func finishRecording(success: Bool) {
        view.backgroundColor = UIColor(red: 0.6, green: 0, blue: 0, alpha: 1)
        
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextTapped))
            audioExists = true
        } else {
            
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
    
    
    //    //commented out
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
    
    //
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
        //        if (playButton.isEnabled) {
        //            audioPlayer?.stop();
        //            return;
        //        }
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
    
    
    @IBOutlet weak var selectedImageView: UIImageView!

    
    @IBAction func onPhotoButton(_ sender: Any) throws {
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            source = "camera"
            cameraImagePickerController.delegate = self
            cameraImagePickerController.sourceType = .camera
            present(cameraImagePickerController, animated: true, completion: nil)
        }
        else {
            throw AddEntryError.noCameraInSimulator
        }
    }
    
    
    @IBAction func selectCameraRollButton(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            source = "gallery"
            cameraImagePickerController.delegate = self
            cameraImagePickerController.sourceType = .savedPhotosAlbum
            cameraImagePickerController.allowsEditing = false
            
            present(cameraImagePickerController, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in
                    })
        selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        selectedImageView.image = selectedImage
    }
    
    
    func saveImage(imageName: String){
        let fileManager = FileManager.default
        // get image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        // obtain image taken with camera
        let img = selectedImageView.image!
        let data = UIImagePNGRepresentation(img)
        // store file in document directory
//        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        
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


}
