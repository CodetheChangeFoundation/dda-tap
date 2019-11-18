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
    var cameraRollPickerController : UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedImageView.image = UIImage(named: "TakePictureImage")
    }
    
    
    @IBOutlet weak var selectedImageView: UIImageView!

    
    @IBAction func onPhotoButton(_ sender: Any) {
        cameraImagePickerController = UIImagePickerController()
        cameraImagePickerController.delegate = self
        cameraImagePickerController.sourceType = .camera
        present(cameraImagePickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func selectCameraRollButton(_ sender: Any) {
        
        cameraRollPickerController = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            cameraRollPickerController.delegate = self
            cameraRollPickerController.sourceType = .savedPhotosAlbum
            cameraRollPickerController.allowsEditing = false
            
            present(cameraRollPickerController, animated: true, completion: nil)
        }
    }
    
    
    func cameraRollPickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
        })
        selectedImageView.image = image
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        cameraImagePickerController.dismiss(animated: true, completion: nil)
        selectedImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    
    func saveImage(imageName: String){
        let fileManager = FileManager.default
        //get the image path
        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
        //get the image we took with camera
        let image = selectedImageView.image!
        let data = UIImagePNGRepresentation(image)
        //store it in the document directory
        fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
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
