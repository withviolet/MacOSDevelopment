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
    @IBOutlet weak var segementSwitch: UISegmentedControl!
    @IBOutlet weak var sliderValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func switchValueChanged(_ sender: Any) {
        let witchSwitch = sender as! UISwitch
        //isOn是要变成的状态
        let setting = witchSwitch.isOn
        self.leftSwitch.setOn(setting, animated: true)
        self.rightSwitch.setOn(setting, animated: true)
    }
    
    @IBAction func touchDown(_ sender: Any) {
        let segementedControl = sender as! UISegmentedControl
        print("choosed : ",segementedControl.selectedSegmentIndex)
        
        if(self.leftSwitch.isHidden == true) {
            self.rightSwitch.isHidden = false
            self.leftSwitch.isHidden = false
        }else{
            self.rightSwitch.isHidden = true
            self.leftSwitch.isHidden = true
        }
    }
    
    @IBAction func sliderValueChange(_ sender: Any) {
//        if(sender != nil) {
//
//        }else{
//            let slider =
//        }
        let slider = sender as! UISlider
        let progressAsInt = Int(slider.value)
        let newText = String(progressAsInt)
        self.sliderValueLabel.text = newText
    }
    
    
}

