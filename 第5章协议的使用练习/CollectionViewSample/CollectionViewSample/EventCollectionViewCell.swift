//
//  EventCollectionViewCell.swift
//  CollectionViewSample
//
//  Created by Chen Xiaohan on 2021/9/9.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
        let cellWidth: CGFloat = self.frame.size.width
        let cellHeight: CGFloat = self.frame.size.height
        
        let imageViewWidth: CGFloat = 32
        let imageViewHeight: CGFloat = 32
//        let imageViewTopView: CGFloat = 5
        
        self.imageView = UIImageView(frame: CGRect(x: cellWidth / 4, y: cellHeight / 4, width: imageViewWidth, height: imageViewHeight))
        self.imageView.backgroundColor = .green
        self.addSubview(self.imageView)
        
        let labelWidth: CGFloat = 32
        let labelHeigth: CGFloat = 11
//        let labelTopView: CGFloat = 70
        
        self.label = UILabel(frame: CGRect(x: cellWidth / 4, y: cellHeight / 4 + 30, width: labelWidth, height: labelHeigth))
        self.label.textAlignment = .center
        self.label.backgroundColor = .red
        self.label.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(self.label)
    }
     
}
