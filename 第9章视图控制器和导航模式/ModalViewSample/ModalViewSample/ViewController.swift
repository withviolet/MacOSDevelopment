//
//  ViewController.swift
//  ModalViewSample
//
//  Created by Chen Xiaohan on 2021/9/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.registerCompletion(notification:)),
                                               name: Notification.Name(rawValue: "RegisterCompletionNotification"),
                                               object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        NotificationCenter.default.removeObserver(self)
    }

    @objc func registerCompletion(notification: Notification) -> Void {
//        let theData: NSDictionary? = notification.userInfo as? NSDictionary
//        let username = theData?["username"] as? String
//        print("username = ",username)
        let name = notification.userInfo?["username"]
        print(name!)
    }

}

