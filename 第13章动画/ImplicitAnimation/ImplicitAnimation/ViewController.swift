//
//  ViewController.swift
//  ImplicitAnimation
//
//  Created by Chen Xiaohan on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {
    var plane: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let screen = UIScreen.main.bounds
        
        let imageWidth: CGFloat = 100
        let imageHeight: CGFloat = 100
        let imageTopView: CGFloat = 25
        let imageLeftView: CGFloat = 20
        let imageFrame = CGRect(x: imageLeftView, y: imageTopView, width: imageWidth, height: imageHeight)
        self.plane = UIImageView(frame: imageFrame)
        self.plane.image = UIImage(named: "ball.png")
        self.plane.layer.opacity = 0.25
        self.view.addSubview(self.plane)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ball.png"), for: .normal)
        button.addTarget(self, action: #selector(movePlane(_:)), for: .touchUpInside)
        
        let buttonWidth: CGFloat = 130
        let buttonHeight: CGFloat = 50
        let buttonTopView: CGFloat = 500
        button.frame = CGRect(x: (screen.size.width - buttonWidth) / 2, y: buttonTopView, width: buttonWidth, height: buttonHeight)
        self.view.addSubview(button)
    }
    //隐式动画
    @objc func movePlane(_ sender: AnyObject) {
        let moveTransform = CGAffineTransform(translationX: 200, y: 300)
        self.plane.layer.setAffineTransform(moveTransform)
        self.plane.layer.opacity = 1
    }
    
    //显式动画
    @objc func movePlane1(_ sender: AnyObject) {
        let opAnim = CABasicAnimation(keyPath: "opacity")
        opAnim.duration = 3.0
        //透明度开始值
        opAnim.fromValue = 0.25
        opAnim.toValue = 1.0
        //累计上次值
        opAnim.isCumulative = true
        opAnim.repeatCount = 2
        opAnim.fillMode = .forwards
        opAnim.isRemovedOnCompletion = false
        self.plane.layer.add(opAnim, forKey: "animateOpacity")
        
        let moveTransform = CGAffineTransform(translationX: 200, y: 300)
        let moveAnim = CABasicAnimation(keyPath: "transform")
        moveAnim.duration = 6.0
        moveAnim.toValue = NSValue(caTransform3D: CATransform3DMakeAffineTransform(moveTransform))
        moveAnim.fillMode = .forwards
        moveAnim.isRemovedOnCompletion = false
        self.plane.layer.add(moveAnim,forKey: "animateTransform")
    }

}

