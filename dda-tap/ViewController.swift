//
//  ViewController.swift
//  dda-tap
//
//  Created by Shirley Yang on 2019-10-26.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // new object AudioRecordingController added to view controller stack
    // probably don't need this
    @objc func addAudio() {
        let vc = AudioRecordingViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


}

