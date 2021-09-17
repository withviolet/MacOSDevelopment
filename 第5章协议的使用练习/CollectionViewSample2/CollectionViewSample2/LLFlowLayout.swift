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
    
    override func prepare() {
        super.prepare()
        self.scrollDirection = .horizontal
        //每个item之间的距离
        self.minimumLineSpacing = 50
        self.itemSize = CGSize(width: 64, height: 64)

    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    //自定义布局的数组
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)!
//        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        //整个显示框的大小
        var visibleRect: CGRect = .zero
        visibleRect.origin = self.collectionView!.contentOffset
        visibleRect.size = self.collectionView!.frame.size
        //显示框的中心x
        let currentViewCenterX = visibleRect.origin.x + visibleRect.width / 2
        //遍历所有图片
        for item in array {
            if(!item.frame.intersects(visibleRect)){
                continue
            }
            let scale: CGFloat
            if(abs(item.center.x - currentViewCenterX) >= visibleRect.size.width / 2) {
                scale = 1
            }else{
                scale = 1 + 0.8 * (1 - abs(item.center.x - currentViewCenterX) / visibleRect.size.width)
            }
            item.transform3D = CATransform3DMakeScale(scale, scale, 1)
        }
        return array
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var contentFrame:CGRect = .zero
        contentFrame.size = self.collectionView!.frame.size
        contentFrame.origin = proposedContentOffset
        let array = self.layoutAttributesForElements(in: contentFrame)!

        var minCenterX = CGFloat.greatestFiniteMagnitude
        let currentViewCenterX = proposedContentOffset.x + self.collectionView!.frame.size.width / 2
        for attrs in array {
            if(abs(attrs.center.x - currentViewCenterX) < abs(minCenterX)) {
                minCenterX = attrs.center.x - currentViewCenterX
            }
        }

        return CGPoint(x: proposedContentOffset.x + minCenterX, y: proposedContentOffset.y)
    }
    
}
