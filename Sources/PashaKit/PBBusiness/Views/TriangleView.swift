//
//  TriangleView.swift
//  
//
//  Created by Farid Valiyev on 07.08.23.
//

import UIKit

class TriangleView : UIView {
    
    var isAlwaysLight = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.minY))
        context.closePath()
        
//        context.setFillColor(!isAlwaysLight ? Colors.shark94AndSnow94.color.cgColor :  Colors.snow94.color.cgColor)
        context.fillPath()
    }
}

class InvertedTriangleView : UIView {
    
    var isAlwaysLight = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        context.closePath()
        
//        context.setFillColor(!isAlwaysLight ? Colors.shark94AndSnow94.color.cgColor :  Colors.snow94.color.cgColor)
        context.fillPath()
    }
}

class LeftTriangleView : UIView {
    
    var isAlwaysLight = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: (rect.maxY / 2.0)))
        context.closePath()
        
//        context.setFillColor(!isAlwaysLight ? Colors.shark94AndSnow94.color.cgColor :  Colors.snow94.color.cgColor)
        context.fillPath()
    }
}

class RightTriangleView : UIView {
    
    var isAlwaysLight = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: (rect.maxY / 2.0)))
        context.closePath()
        
//        context.setFillColor(!isAlwaysLight ? Colors.shark94AndSnow94.color.cgColor :  Colors.snow94.color.cgColor)
        context.fillPath()
    }
}
