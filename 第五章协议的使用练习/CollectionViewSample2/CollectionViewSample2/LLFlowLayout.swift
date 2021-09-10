//
//  LLFlowLayout.swift
//  CollectionViewSample2
//
//  Created by Chen Xiaohan on 2021/9/10.
//

import UIKit

class LLFlowLayout: UICollectionViewFlowLayout {
    var attributeArray = Array<Any>()
    let itemWidth = 100
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    //自定义布局的数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return array
    }
    
    override func prepareForTransition(to newLayout: UICollectionViewLayout) {
        super.prepareForTransition(to: newLayout)
    }
    
}
