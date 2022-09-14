//
//  ScannerCutOutPathView.swift
//  QRCodeScanner
//
//  Created by Sejal Khanna on 02/09/21.
//

import UIKit

// MARK:- BeizerPath Curve
class ScannerCutOutPathView: UIView {
    
    func createSquare(frame:CGRect) {
        
        let path = UIBezierPath(rect: frame)
        let width = frame.size.width
        let height =  frame.size.height
        
        path.move(to: CGPoint(x: width/4, y: height/4))
        path.addLine(to: CGPoint(x: width/4, y: 3*(height/4)))
        path.addLine(to: CGPoint(x: 3*(width/4), y: 3*(height/4)))
        path.addLine(to: CGPoint(x:  3*(width/4), y: height/4))
        path.addLine(to: CGPoint(x: width/4, y: height/4))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        self.layer.mask = maskLayer
        
        UIColor.systemBlue.setStroke()
        path.lineWidth = 3.0
        path.stroke()
         
    }
    override func draw(_ rect: CGRect) {
        createSquare(frame: rect)
    }
    
}

