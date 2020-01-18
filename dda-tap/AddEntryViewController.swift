//
//  AddEntryViewController.swift
//  dda-tap
//
//  Created by Kushagra Sharma on 2019-10-27.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var cameraImagePickerController : UIImagePickerController!
    var source : String!
    var selectedImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageView.image = UIImage(named: "TakePictureImage")
        cameraImagePickerController = UIImagePickerController()
    }
    
    
    @IBOutlet weak var selectedImageView: UIImageView!

    
    @IBAction func onPhotoButton(_ sender: Any) {
        source = "camera"
        cameraImagePickerController.delegate = self
        cameraImagePickerController.sourceType = .camera
        present(cameraImagePickerController, animated: true, completion: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
