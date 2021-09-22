//
//  RegisterViewController.swift
//  ModalViewSample
//
//  Created by Chen Xiaohan on 2021/9/17.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userNameTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        let dataDict = ["username" : self.userNameTextFiled.text!]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "RegisterCompletionNotification"), object: nil, userInfo: dataDict)
        print("点击取消按钮")
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        self.dismiss(animated: true) {
            print("如果你是难得一见的彩虹，我愿做路人惊叹的叫声\n")
            print("关闭模态视图")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
