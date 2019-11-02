//
//  CameraViewController.swift
//  dda-tap
//
//  Created by Kushagra Sharma on 2019-10-27.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var imagePickerController : UIImagePickerController!
    
    
    @IBOutlet var imageView: UIImageView!

    
    @IBAction func onPhotoButton(_ sender: Any) {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let img: UIImage = UIImage(named: "TakePictureImage")!
        imageView.image = UIImage(named: "TakePictureImage")
        

        // Do any additional setup after loading the view.
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
