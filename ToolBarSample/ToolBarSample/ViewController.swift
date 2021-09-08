//
//  ViewController.swift
//  ToolBarSample
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
    
    @IBAction func open(_ sender: Any) {
        self.label.text = "点击寄"
    }
    
}

