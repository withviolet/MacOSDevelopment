//
//  ViewController.swift
//  NavigationBarSample
//
//  Created by Chen Xiaohan on 2021/9/8.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: Any) {
        self.label.text = "点击save"
    }
    
    @IBAction func add(_ sender: Any) {
        self.label.text = "点击add"
    }
}

