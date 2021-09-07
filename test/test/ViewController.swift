//
//  ViewController.swift
//  test
//
//  Created by Chen Xiaohan on 2021/9/7.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var myButton: UIButton!
    
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clicked(_ sender: Any) {
        let url = URL(string: "https://www.baidu.com")
        let request = URLRequest(url: url!)
        self.myWebView.load(request)
    }
    
}

