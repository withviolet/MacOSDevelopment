//
//  ViewController.swift
//  CollectionViewSample2
//
//  Created by Chen Xiaohan on 2021/9/9.
//

import UIKit
let COL_NUM = 10
class ViewController: UIViewController,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK: delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return COL_NUM
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.section * COL_NUM + indexPath.row
        print("select event name:",index)
    }
    
    //MARK: dataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        let index = indexPath.section * COL_NUM + indexPath.row
        let imageNameString = String(index + 1) + ".png"
        let image = UIImage(named: imageNameString)
        cell.imageView.image = image
        return cell
    }
    
    
}

