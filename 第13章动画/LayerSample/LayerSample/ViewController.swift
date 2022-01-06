//
//  ViewController.swift
//  LayerSample
//
//  Created by Chen Xiaohan on 2021/10/29.
//

import UIKit

class ViewController: UIViewController {
    var ballLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //UIView动画的底层是core animation实现的，所以此案例展示了一下core animation中的图层
        //
        self.ballLayer = CALayer()
        
        let image = UIImage(named: "ball.png")
        self.ballLayer.contents = image?.cgImage
        self.ballLayer.contentsGravity = .resizeAspect
        self.ballLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 125.0, height: 125.0)
        self.ballLayer.position = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        self.view.layer.addSublayer(self.ballLayer)
    }


}

