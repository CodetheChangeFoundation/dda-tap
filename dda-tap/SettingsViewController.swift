//
//  SettingsViewController.swift
//  dda-tap
//
//  Created by Steve Farra on 2019-11-02.
//  Copyright © 2019 Code the Change. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        switch1.isOn = userDefaults.bool(forKey: "switch1")
        switch2.isOn = userDefaults.bool(forKey: "switch2")
        switch3.isOn = userDefaults.bool(forKey: "switch3")
        switch4.isOn = userDefaults.bool(forKey: "switch4")
        switch5.isOn = userDefaults.bool(forKey: "switch5") 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch1.isOn = userDefaults.bool(forKey: "switch1")
        switch2.isOn = userDefaults.bool(forKey: "switch2")
        switch3.isOn = userDefaults.bool(forKey: "switch3")
        switch4.isOn = userDefaults.bool(forKey: "switch4")
        switch5.isOn = userDefaults.bool(forKey: "switch5")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var switch4: UISwitch!
    @IBOutlet weak var switch5: UISwitch!
    
    
    @IBAction func toggleSwitch1(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "switch1")
    }
    
    @IBAction func toggleSwitch2(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "switch2")
    }
    
    
    @IBAction func toggleSwitch3(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "switch3")
    }
    
    
    @IBAction func toggleSwitch4(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "switch4")
    }
    
    

    @IBAction func toggleSwitch5(_ sender: UISwitch) {
        userDefaults.set(sender.isOn, forKey: "switch5")
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
