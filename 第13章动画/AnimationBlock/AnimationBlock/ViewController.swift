//
//  ViewController.swift
//  AnimationBlock
//
//  Created by Chen Xiaohan on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {
    //ball's animate direction
    var flag = 1;
    var ball: UIImageView!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //create ball
        let screen = UIScreen.main.bounds
        
        let imageWidth: CGFloat = 86
        let imageHeight: CGFloat = 86
        let imageTopView: CGFloat = 150
        let imageFrame = CGRect(x: (screen.size.width - imageWidth) / 2, y: imageTopView, width: imageWidth, height: imageHeight)
        
        self.ball = UIImageView(frame: imageFrame)
        self.ball.image = UIImage(named: "ball.png")
        self.view.addSubview(self.ball)
        
        //create button
        button = UIButton(type: .custom)
        button.setImage(UIImage(named: "ball.png"), for: .normal)
//        button.setImage(UIImage(named: ""), for: .highlighted)
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
        
        let buttonWidth: CGFloat = 130
        let buttonHeight: CGFloat = 50
        let buttonTopView: CGFloat = 500
        button.frame = CGRect(x: (screen.size.width - buttonWidth) / 2, y: buttonTopView, width: buttonWidth, height: buttonHeight)
        self.view.addSubview(button)
    }

    @objc func onClick(_ sender: AnyObject) {
        //the example point is using this function,making the ball move
//        UIView.animate(withDuration: 1.5) {
//            var frame = self.ball.frame
//            frame.origin.y += CGFloat(200 * self.flag)
//            self.flag *= -1
//            self.ball.frame = frame
//        }
        //after clicked button, ball will move and the button will disappear
        self.button.alpha = 0.0
        UIView.animate(withDuration: 1.5) {
            var frame = self.ball.frame
            frame.origin.y += CGFloat(200 * self.flag)
            self.flag *= -1
            self.ball.frame = frame
        } completion: { _ in
            //after the animation complete the button will appear again.
            self.button.alpha = 1.0
        }

    }

}

