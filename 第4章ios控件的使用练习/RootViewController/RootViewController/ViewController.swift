//
//  ViewController.swift
//  RootViewController
//
//  Created by Chen Xiaohan on 2021/9/6.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    //UITextFieldDelegate委托协议方法
    //编辑textField后回车调用
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //编辑textView后回车调用
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            print("TextView获得焦点，点击return")
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

