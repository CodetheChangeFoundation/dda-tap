//
//  SettingsViewController.swift
//  dda-tap
//
//  Created by Steve Farra on 2019-11-02.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var switch2State = UserDefaults().string(forKey: "switch2") ?? "On"
    var switch3State = UserDefaults().string(forKey: "switch3") ?? "On"
    var switch4State = UserDefaults().string(forKey: "switch4") ?? "On"
    var switch5State = UserDefaults().string(forKey: "switch5") ?? "On"
    var switch6State = UserDefaults().string(forKey: "switch6") ?? "On"
    
    @IBOutlet weak var switch2: UISwitch!
    @IBAction func toggleSwitch2(_ sender: Any) {
        UserDefaults().set(switch2State == "On" ? "Off" : "On", forKey: "switch2")
    }
    
    
    @IBOutlet weak var switch3: UISwitch!
    @IBAction func toggleSwitch3(_ sender: Any) {
        UserDefaults().set(switch3State == "On" ? "Off" : "On", forKey: "switch3")
    }
    

    @IBOutlet weak var switch4: UISwitch!
    @IBAction func toggleSwitch4(_ sender: Any) {
        UserDefaults().set(switch4State == "On" ? "Off" : "On", forKey: "switch4")
    }
    
    @IBOutlet weak var switch5: UISwitch!
    @IBAction func toggleSwitch5(_ sender: Any) {
        UserDefaults().set(switch5State == "On" ? "Off" : "On", forKey: "switch5")
    }
    
    @IBOutlet weak var switch6: UISwitch!
    @IBAction func toggleSwitch6(_ sender: Any) {
        UserDefaults().set(switch6State == "On" ? "Off" : "On", forKey: "switch6")
    }
    
    
    @IBAction func onVolumeSlider(_ sender: Any) {
        // Volume slider functionality
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        switch2.isOn = (switch2State == "On")
        switch3.isOn = (switch3State == "On")
        switch4.isOn = (switch4State == "On")
        switch5.isOn = (switch5State == "On")
        switch6.isOn = (switch6State == "On")
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
