//
//  RangeSlider.swift
//  PriceSlider
//
//  Created by Chen Xiaohan on 2021/8/26.
//

import UIKit

class RangeSlider: UIControl {
    var minValue: CGFloat = 0
    var maxValue: CGFloat = 1
    var lowValue: CGFloat = 0.2
    var highValue: CGFloat = 0.8
    
    var thumbImage: UIImage = UIImage(named: "hot_emoji")!
    
    private let trackLayer = CALayer()
    private let lowThumbImageView = UIImageView()
    private let highThumbImageView = UIImageView()
    //手指落下的点
    private var previousLocation = CGPoint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        trackLayer.backgroundColor = UIColor.darkGray.cgColor
        layer.addSublayer(trackLayer)
        
        lowThumbImageView.image = thumbImage
        addSubview(lowThumbImageView)
        
        highThumbImageView.image = thumbImage
        addSubview(highThumbImageView)
        
        //更新方法
        updateLayerFrames()
    }
    
    override var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateLayerFrames() {
        trackLayer.frame = bounds.insetBy(dx: 0.0, dy: bounds.height / 3)
        trackLayer.setNeedsDisplay()
        lowThumbImageView.frame = CGRect(origin: thumbOriginForValue(lowValue), size: thumbImage.size)
        highThumbImageView.frame = CGRect(origin: thumbOriginForValue(highValue), size: thumbImage.size)
    }
    
    func positionForValue(_ value: CGFloat) -> CGFloat {
        return bounds.width * value
    }
    
    //指示器的位置
    private func thumbOriginForValue(_ value: CGFloat) -> CGPoint {
        let x = positionForValue(value) - thumbImage.size.width / 2.0
        return CGPoint(x: x, y: (bounds.height - thumbImage.size.height) / 2.0)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        //触摸事件
        previousLocation = touch.location(in: self)
        
        if lowThumbImageView.frame.contains(previousLocation) {
            lowThumbImageView.isHighlighted = true
        }else if highThumbImageView.frame.contains(previousLocation) {
            highThumbImageView.isHighlighted = true
        }
        return lowThumbImageView.isHighlighted || highThumbImageView.isHighlighted
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let deltaLocation = location.x - previousLocation.x
        let deltaValue = (maxValue - minValue) * deltaLocation / bounds.width
        previousLocation = location
        
        if lowThumbImageView.isHighlighted {
            lowValue += deltaValue
            lowValue = boundValue(lowValue, toLowValue: minValue, highValue: highValue)
        }else if highThumbImageView.isHighlighted {
            highValue += deltaValue
            highValue = boundValue(highValue, toLowValue: lowValue, highValue: maxValue)
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        updateLayerFrames()
        
        CATransaction.commit()
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowThumbImageView.isHighlighted = false
        highThumbImageView.isHighlighted = false
    }
    
    private func boundValue(_ value: CGFloat, toLowValue lowValue:CGFloat, highValue:CGFloat) -> CGFloat {
        return min(max(value, lowValue), highValue)
    }
}
