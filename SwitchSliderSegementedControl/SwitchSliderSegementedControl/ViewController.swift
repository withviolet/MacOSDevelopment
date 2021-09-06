//
//  ViewController.swift
//  SwitchSliderSegementedControl
//
//  Created by Chen Xiaohan on 2021/9/6.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var leftSwitch: UISwitch!
    @IBOutlet weak var rightSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func switchValueChanged(_ sender: Any) {
        let witchSwitch = sender as! UISwitch
        let setting = witchSwitch.isOn
        self.leftSwitch.setOn(setting, animated: true)
        self.rightSwitch.setOn(setting, animated: true)
    }
    
}

