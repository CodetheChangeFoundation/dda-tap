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
        handleFirstLoadIfNeeded()
        loadSwitchesAndTextFields()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadSwitchesAndTextFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleFirstLoadIfNeeded() {
        if (userDefaults.object(forKey: "switch1") == nil) {
            userDefaults.set(true, forKey:"switch1")
            userDefaults.set(true, forKey:"switch2")
            userDefaults.set(true, forKey:"switch3")
            userDefaults.set(true, forKey:"switch4")
            userDefaults.set(true, forKey:"switch5")
        }
        if (userDefaults.object(forKey: "textField1") == nil) {
            userDefaults.set("Screen1", forKey: "textField1")
            userDefaults.set("Screen2", forKey: "textField2")
            userDefaults.set("Screen3", forKey: "textField3")
            userDefaults.set("Screen4", forKey: "textField4")
            userDefaults.set("Screen5", forKey: "textField5")
        }
    }
    
    func loadSwitchesAndTextFields() {
        switch1.isOn = userDefaults.bool(forKey: "switch1")
        switch2.isOn = userDefaults.bool(forKey: "switch2")
        switch3.isOn = userDefaults.bool(forKey: "switch3")
        switch4.isOn = userDefaults.bool(forKey: "switch4")
        switch5.isOn = userDefaults.bool(forKey: "switch5")
        
        textField1.text = userDefaults.string(forKey: "textField1")
        textField2.text = userDefaults.string(forKey: "textField2")
        textField3.text = userDefaults.string(forKey: "textField3")
        textField4.text = userDefaults.string(forKey: "textField4")
        textField5.text = userDefaults.string(forKey: "textField5")
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
    
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    
    
    @IBAction func onTextField1Changed(_ sender: UITextField) {
        userDefaults.set(sender.text, forKey: "textField1")
    }
    
    @IBAction func onTextField2Changed(_ sender: UITextField) {
        userDefaults.set(sender.text, forKey: "textField2")
    }
    
    @IBAction func onTextField3Changed(_ sender: UITextField) {
        userDefaults.set(sender.text, forKey: "textField3")
    }
    
    @IBAction func onTextField4Changed(_ sender: UITextField) {
        userDefaults.set(sender.text, forKey: "textField4")
    }
    
    @IBAction func onTextField5Changed(_ sender: UITextField) {
        userDefaults.set(sender.text, forKey: "textField5")
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
