//
//  ViewController.swift
//  PriceSlider
//
//  Created by Chen Xiaohan on 2021/8/26.
//

import UIKit

class ViewController: UIViewController {
    let rangeSlider: RangeSlider = RangeSlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeSlider.backgroundColor = .lightGray
        view.addSubview(rangeSlider)
    }

    override func viewDidLayoutSubviews() {
        let margin: CGFloat = 20
        let width = view.bounds.width - 2 * margin
        let height: CGFloat = 10
        
        rangeSlider.frame = CGRect(x: 0, y: 0, width: width, height: height)
        rangeSlider.center = view.center
        
    }
    

}

