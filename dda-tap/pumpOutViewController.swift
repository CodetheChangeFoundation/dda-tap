//
//  pumpOutViewController.swift
//  dda-tap
//
//  Created by Fengpeng Huang on 2020-02-29.
//  Copyright © 2020 Code the Change. All rights reserved.
//

import UIKit

class pumpOutViewController: UIViewController {

    @IBOutlet weak var image: UIButton!
    var image_data=UIImage()
    var hi=1
    override func viewDidLoad() {
//        super.viewDidLoad()
        image.setImage(self.image_data, for:  UIControl.State.normal)
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
