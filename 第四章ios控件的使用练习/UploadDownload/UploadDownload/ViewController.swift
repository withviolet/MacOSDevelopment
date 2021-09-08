//
//  ViewController.swift
//  UploadDownload
//
//  Created by Chen Xiaohan on 2021/9/8.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var progressView: UIProgressView!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startToMove(_ sender: Any) {
        if (self.activityIndicatorView.isAnimating) {
            self.activityIndicatorView.stopAnimating()
        }else{
            self.activityIndicatorView.startAnimating()
        }
    }
    @IBAction func startToDownLoad(_ sender: Any) {
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(download), userInfo: nil, repeats: true)
        
    }
    
    @objc func download() {
        self.progressView.progress = self.progressView.progress + 0.01
        if(self.progressView.progress == 1.0) {
            self.timer.invalidate()
            
            let alertController: UIAlertController = UIAlertController(title: "下载完成", message: "寄了吧", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "寄", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


