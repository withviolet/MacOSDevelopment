//
//  CollectionViewCell.swift
//  CollectionViewSample2
//
//  Created by Chen Xiaohan on 2021/9/9.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var imageView:UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        let width = self.contentView.frame.width
//        print(width)
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        self.addSubview(self.imageView)
        
    }
}
