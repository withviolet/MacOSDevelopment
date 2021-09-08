//
//  ViewController.swift
//  AlertActionSample
//
//  Created by Chen Xiaohan on 2021/9/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func testAlertView(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "丫头，眼神骗不了人", message: "想我了吧？", preferredStyle: UIAlertController.Style.alert)
        let noAction = UIAlertAction(title: "是", style: .cancel) { (alertAction) -> Void in
            print("Tap No Button")
        }
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (alertAction) -> Void in
            print("Tap Yes Button")
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true, completion: nil)
    }
    

    @IBAction func testActionSheet(_ sender: Any) {
        let actionSheetController = UIAlertController()
        let cancelAction = UIAlertAction(title: "头像是我，你不满意？", style: UIAlertAction.Style.cancel) { (alertAction) -> Void in
            print("满意地取消按钮")
        }
        let destructiveAction = UIAlertAction(title: "丫头，真想狠狠把你拌了", style: UIAlertAction.Style.destructive) { (alertAction) -> Void in
            print("破坏性按钮")
        }
        let otherAction = UIAlertAction(title: "自己想办法爱上我", style: UIAlertAction.Style.default) { (alertAction) -> Void in
            print("普通按钮")
        }
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(destructiveAction)
        actionSheetController.addAction(otherAction)
        
        //为ipad设置锚点
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        self.present(actionSheetController, animated: true, completion: nil)
    }
}

