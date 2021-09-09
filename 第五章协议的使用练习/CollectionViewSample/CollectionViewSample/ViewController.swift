//
//  ViewController.swift
//  CollectionViewSample
//
//  Created by Chen Xiaohan on 2021/9/9.
//

import UIKit

let COL_NUM = 3

class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var events: NSArray!
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "events", ofType: "plist")
        self.events = NSArray(contentsOfFile: plistPath!)
        
        self.setUpCollectionView()
    }
    
    func setUpCollectionView() -> Void {
        let screenSize = UIScreen.main.bounds.size
//        (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = CGSize.init(width: 100, height: 100)
        if(screenSize.height > 568) {
//            flowLayout.itemSize = CGSize(width: 100, height: 100)
//            flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 20, right: 15)
            
        }
        flowLayout.minimumInteritemSpacing = 5
    }

    //MARK: delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = self.events[(indexPath as NSIndexPath).section * COL_NUM + (indexPath as NSIndexPath).row] as! NSDictionary
        print("select event name:",event["name"] ?? "wu")
    }
    
    //MARK: dataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        let num = self.events.count % COL_NUM
        if(num == 0) {
            return self.events.count / COL_NUM
        }else{
            return self.events.count / COL_NUM + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_NUM
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! EventCollectionViewCell
        
        let index = indexPath.section * COL_NUM + indexPath.row
        
        if(self.events.count <= index) {
            return cell
        }
        
        let event = self.events[index] as! NSDictionary
        
        cell.label?.text = event["name"] as? String
        cell.imageView?.image = UIImage(named: event["image"] as! String)
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize.init(width: 100, height: 100)
//    }
    
}

