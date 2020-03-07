//
//  ImageViewController.swift
//  dda-tap
//
//  Created by Fengpeng Huang on 2020-02-22.
//  Copyright © 2020 Code the Change. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var image_1: UIButton!
    @IBOutlet weak var image_2: UIButton!
    @IBOutlet weak var image_3: UIButton!
    @IBOutlet weak var image_4: UIButton!
    @IBOutlet weak var image_5: UIButton!
    @IBOutlet weak var image_6: UIButton!
    var img_1=UIImage()
    var img_2=UIImage()
    var img_3=UIImage()
    var img_4=UIImage()
    var img_5=UIImage()
    var img_6=UIImage()
    
//    var image_1_exit=false
    
//    @IBAction func button_1(_ sender: UIButton) {
//        performSegue(withIdentifier: "pumpOut", sender: self)
//    }
//
//
//    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
//        let vc=segue.destination as! pumpOutViewController
//        vc.hi=21
//        if(self.image_1_exit){
//            vc.image_data=self.img_1
////            vc.image.setImage(self.img_1, for: UIControl.State.normal)
//        }
//
//    }

    
    var num=1
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x_1=UserDefaults.standard.object(forKey: "save_image_1") as? Data, let image_x_1 = UIImage(data: x_1) {
                image_1.setImage(image_x_1, for: UIControl.State.normal)
        
        }
        if let x_2=UserDefaults.standard.object(forKey: "save_image_2") as? Data, let image_x_2 = UIImage(data: x_2) {
                image_2.setImage(image_x_2, for: UIControl.State.normal)
        
        }
        if let x_3=UserDefaults.standard.object(forKey: "save_image_3") as? Data, let image_x_3 = UIImage(data: x_3) {
                image_3.setImage(image_x_3, for: UIControl.State.normal)
        
        }
        if let x_4=UserDefaults.standard.object(forKey: "save_image_4") as? Data, let image_x_4 = UIImage(data: x_4) {
                image_4.setImage(image_x_4, for: UIControl.State.normal)
        
        }
        if let x_5=UserDefaults.standard.object(forKey: "save_image_5") as? Data, let image_x_5 = UIImage(data: x_5) {
                image_5.setImage(image_x_5, for: UIControl.State.normal)
        
        }
        if let x_6=UserDefaults.standard.object(forKey: "save_image_6") as? Data, let image_x_6 = UIImage(data: x_6) {
                image_6.setImage(image_x_6, for: UIControl.State.normal)
        
        }
    }
    
    @IBAction func unwindToImage_1(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
        
        if(self.num==1){
            image_1.setImage(self.img_1, for: UIControl.State.normal)
//            self.image_1_exit=true
            if let pngRepresentation_1 = UIImagePNGRepresentation(self.img_1){
                UserDefaults.standard.set(pngRepresentation_1,forKey: "save_image_1")
            }
            
        }else if(self.num==2){
            image_2.setImage(self.img_2, for: UIControl.State.normal)
            if let pngRepresentation_2 = UIImagePNGRepresentation(self.img_2){
                UserDefaults.standard.set(pngRepresentation_2,forKey: "save_image_2")
            }
        }else if(self.num==3){
            image_3.setImage(self.img_3, for: UIControl.State.normal)
            if let pngRepresentation_3 = UIImagePNGRepresentation(self.img_3){
                UserDefaults.standard.set(pngRepresentation_3,forKey: "save_image_3")
            }
        }else if(self.num==4){
            image_4.setImage(self.img_4, for: UIControl.State.normal)
            if let pngRepresentation_4 = UIImagePNGRepresentation(self.img_4){
                UserDefaults.standard.set(pngRepresentation_4,forKey: "save_image_4")
            }
        }else if(self.num==5){
            image_5.setImage(self.img_5, for: UIControl.State.normal)
            if let pngRepresentation_5 = UIImagePNGRepresentation(self.img_5){
                UserDefaults.standard.set(pngRepresentation_5,forKey: "save_image_5")
            }
        }else if(self.num==6){
            image_6.setImage(self.img_6, for: UIControl.State.normal)
            if let pngRepresentation_6 = UIImagePNGRepresentation(self.img_6){
                UserDefaults.standard.set(pngRepresentation_6,forKey: "save_image_6")
            }
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
