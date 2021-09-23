//
//  ViewController.swift
//  PageControlNavigation
//
//  Created by Chen Xiaohan on 2021/9/23.
//

import UIKit

let S_WIDTH: CGFloat = UIScreen.main.bounds.size.width
let S_HEIGHT: CGFloat = UIScreen.main.bounds.size.height

class ViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var imageView1: UIImageView!
    var imageView2: UIImageView!
    var imageView3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("S_WIDTH",S_WIDTH)
//        print("S_HEIGHT",S_HEIGHT)
        
        // Do any additional setup after loading the view.
        self.scrollView.contentSize = CGSize(width: S_WIDTH * 3, height: S_HEIGHT)
        self.scrollView.frame = self.view.frame
        
        self.imageView1 = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: S_WIDTH, height: S_HEIGHT))
        self.imageView2 = UIImageView(frame: CGRect(x: S_WIDTH, y: 0.0, width: S_WIDTH, height: S_HEIGHT))
        self.imageView3 = UIImageView(frame: CGRect(x: 2 * S_WIDTH, y: 0.0, width: S_WIDTH, height: S_HEIGHT))
        self.imageView1.image = UIImage(named: "IMG_3127.jpg")
        self.imageView2.image = UIImage(named: "IMG_5421.JPG")
        self.imageView3.image = UIImage(named: "IMG_5422.JPG")
        
        self.scrollView.addSubview(self.imageView1)
        self.scrollView.addSubview(self.imageView2)
        self.scrollView.addSubview(self.imageView3)
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("scroll")
        let offset = scrollView.contentOffset
        self.pageControl.currentPage = Int(offset.x / S_WIDTH)
    }

    @IBAction func changePage(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            let selectedPage = self.pageControl.currentPage
            self.scrollView.contentOffset = CGPoint(x: CGFloat(selectedPage) * S_WIDTH, y: 0.0)
        }

    }
}

