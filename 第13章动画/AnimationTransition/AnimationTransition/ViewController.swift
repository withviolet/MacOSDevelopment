//
//  ViewController.swift
//  AnimationTransition
//
//  Created by Chen Xiaohan on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func doUIViewAnimation(_ sender: AnyObject) {
        let button = sender as! UIButton
        NSLog("tag = %i", button.tag)
        
        switch button.tag {
        case 1:
            UIView.transition(with: self.view, duration: 2, options: [.curveEaseOut, .transitionFlipFromLeft]) {
                NSLog("动画开始")
            } completion: { _ in
                NSLog("动画完成")
            }
        case 2:
            UIView.transition(with: self.view, duration: 2, options: [.curveEaseOut, .transitionFlipFromRight]) {
                NSLog("动画开始")
            } completion: { _ in
                NSLog("动画完成")
            }
        case 3:
            UIView.transition(with: self.view, duration: 2, options: [.curveEaseOut, .transitionCurlUp]) {
                NSLog("动画开始")
            } completion: { _ in
                NSLog("动画完成")
            }
        case 4:
            UIView.transition(with: self.view, duration: 2, options: [.curveEaseOut, .transitionCurlDown]) {
                NSLog("动画开始")
            } completion: { _ in
                NSLog("动画完成")
            }

        default:
            UIView.transition(with: self.view, duration: 2, options: [.curveEaseOut, .transitionCurlUp]) {
                NSLog("动画开始")
            } completion: { _ in
                NSLog("动画完成")
            }
        }
    }


}

