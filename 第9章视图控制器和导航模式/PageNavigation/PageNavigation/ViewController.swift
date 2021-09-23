//
//  ViewController.swift
//  PageNavigation
//
//  Created by Chen Xiaohan on 2021/9/23.
//

import UIKit

enum DirectionForward: Int {
    case before = 1
    case after = 2
}

class ViewController: UIViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {

    var pageIndex = 0
    var directionForward = DirectionForward.after
    var pageViewController: UIPageViewController!
    var viewControllers: [UIViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let page1ViewController = UIViewController()
        let page2ViewController = UIViewController()
        let page3ViewController = UIViewController()
        self.pageViewController = UIPageViewController()
        self.viewControllers = [page1ViewController,page2ViewController,page3ViewController]
        
        let imageView1 = UIImageView(frame: self.view.frame)
        let imageView2 = UIImageView(frame: self.view.frame)
        let imageView3 = UIImageView(frame: self.view.frame)
        imageView1.image = UIImage(named: "IMG_3127.jpg")
        imageView2.image = UIImage(named: "IMG_5421.JPG")
        imageView3.image = UIImage(named: "IMG_5422.JPG")
        page1ViewController.view.addSubview(imageView1)
        page2ViewController.view.addSubview(imageView2)
        page3ViewController.view.addSubview(imageView3)
        
        page1ViewController.modalTransitionStyle = .partialCurl
        page2ViewController.modalTransitionStyle = .flipHorizontal
        
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        self.pageViewController.setViewControllers([page1ViewController], direction: .forward, animated: true, completion: nil)
        self.view.addSubview(self.pageViewController.view)
    }

    //MARK: delegate
    func pageViewController(_ pageViewController: UIPageViewController, spineLocationFor orientation: UIInterfaceOrientation) -> UIPageViewController.SpineLocation {
        //不是双页
        self.pageViewController.isDoubleSided = false
        //书脊左侧
        return .min
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed == false) {
            //用户翻页不彻底
            if (directionForward == .after) {
                //向后翻页
                pageIndex -= 1
            }
            if (directionForward == .before) {
                pageIndex += 1
            }
        }
    }
    
    //MARK: dataSource
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        pageIndex -= 1
        if(pageIndex < 0) {
            pageIndex = 0
            return nil
        }
        directionForward = .before
        return self.viewControllers[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        pageIndex += 1
        if(pageIndex > 2) {
            pageIndex = 2
            return nil
        }
        directionForward = .after
        return self.viewControllers[pageIndex]
    }
    

}

