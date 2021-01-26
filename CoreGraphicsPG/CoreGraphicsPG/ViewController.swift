//
//  ViewController.swift
//  CoreGraphicsPG
//
//  Created by KRITSSEAN on 2021/01/25.
//

import UIKit
import CoreGraphics

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIGraphicsBeginImageContext(imgView.frame.size)

        guard let context = UIGraphicsGetCurrentContext() else { return }
                
        let path = CGMutablePath()
        let x = 20
        let y = 20
        let width = 100
        let height = 100
        let fullWidthX = x + width
        let fullHeightY = y + height
//        let radius = 20
        
        var radiusTL = 20.0
        var radiusTR = 0.0
        var radiusBR = 90.0
        var radiusBL = 10.0
        let radiusFactor = self.getRadiusFactor(width: width, height: height, radiusTopLeft: radiusTL, radiusTopRight: radiusTR, radiusBottomRight: radiusBR, radiusBottomLeft: radiusBL)
        
        let radiusTopLeft = Int(radiusTL * radiusFactor)
        let radiusTopRight = Int(radiusTR * radiusFactor)
        let radiusBottomRight = Int(radiusBR * radiusFactor)
        let radiusBottomLeft = Int(radiusBL * radiusFactor)
        
        print("radius factor : \(radiusFactor)")
        print("TL : \(radiusTopLeft)")
        print("TR : \(radiusTopRight)")
        print("BR : \(radiusBottomRight)")
        print("BL : \(radiusBottomLeft)")
        // Add lines
        
        // Top line
        let topLineStartX = x + radiusTopLeft
        let topLineStartY = y
        let topLineEndX = x + width - radiusTopRight
        let topLineEndY = y
        
//        path.move(to: CGPoint(x: topLineStartX, y: topLineStartY))
//        path.addLine(to: CGPoint(x: topLineEndX, y: topLineEndY))
//        path.addArc(tangent1End: CGPoint(x: fullWidthX, y: y), tangent2End: CGPoint(x: fullWidthX, y: fullHeightY), radius: CGFloat(radiusTopRight))
        
        // Right line
        let rightLineStartX = fullWidthX
        let rightLineStartY = y + radiusTopRight
        let rightLineEndX = fullWidthX
        let rightLineEndY = fullHeightY - radiusBottomRight
        
//        path.move(to: CGPoint(x: rightLineStartX, y: rightLineStartY))
//        path.addLine(to: CGPoint(x: rightLineEndX, y: rightLineEndY))
        
        // Bottom line
        let bottomLineStartX = fullWidthX - radiusBottomRight
        let bottomLineStartY = fullHeightY
        let bottomLineEndX = x + radiusBottomLeft
        let bottomLineEndY = fullHeightY
        
//        path.move(to: CGPoint(x: bottomLineStartX, y: bottomLineStartY))
//        path.addLine(to: CGPoint(x: bottomLineEndX, y: bottomLineEndY))
        
        // Left line
        let leftLineStartX = x
        let leftLineStartY = fullHeightY - radiusBottomLeft
        let leftLineEndX = x
        let leftLineEndY = y + radiusTopLeft
        
//        path.move(to: CGPoint(x: leftLineStartX, y: leftLineStartY))
//        path.addLine(to: CGPoint(x: leftLineEndX, y: leftLineEndY))
                
        // Add arcs
        
        // TL
//        path.move(to: CGPoint(x: leftLineEndX, y: leftLineEndY))
//        path.addArc(tangent1End: CGPoint(x: x, y: y), tangent2End: CGPoint(x: fullWidthX, y: y), radius: CGFloat(radiusTopLeft))
        
        // TR
//        path.move(to: CGPoint(x: topLineEndX, y: topLineEndY))
//        path.addArc(tangent1End: CGPoint(x: fullWidthX, y: y), tangent2End: CGPoint(x: fullWidthX, y: fullHeightY), radius: CGFloat(radiusTopRight))
        
        // BR
//        path.move(to: CGPoint(x: fullWidthX, y: rightLineEndY))
//        path.addArc(tangent1End: CGPoint(x: fullWidthX, y: fullHeightY), tangent2End: CGPoint(x: x, y: fullHeightY), radius: CGFloat(radiusBottomRight))
        
        // BL
//        path.move(to: CGPoint(x: bottomLineEndX, y: bottomLineEndY))
//        path.addArc(tangent1End: CGPoint(x: x, y: fullHeightY), tangent2End: CGPoint(x: x, y: y), radius: CGFloat(radiusBottomLeft))
        
        /*
        path.move(to: CGPoint(x: topLineStartX, y: topLineStartY))
        path.addLine(to: CGPoint(x: topLineEndX, y: topLineEndY))
        path.addArc(tangent1End: CGPoint(x: fullWidthX, y: y), tangent2End: CGPoint(x: fullWidthX, y: fullHeightY), radius: CGFloat(radiusTopRight))
        path.addLine(to: CGPoint(x: rightLineEndX, y: rightLineEndY))
        path.addArc(tangent1End: CGPoint(x: fullWidthX, y: fullHeightY), tangent2End: CGPoint(x: x, y: fullHeightY), radius: CGFloat(radiusBottomRight))
        path.addLine(to: CGPoint(x: bottomLineEndX, y: bottomLineEndY))
        path.addArc(tangent1End: CGPoint(x: x, y: fullHeightY), tangent2End: CGPoint(x: x, y: y), radius: CGFloat(radiusBottomLeft))
        path.addLine(to: CGPoint(x: leftLineEndX, y: leftLineEndY))
        path.addArc(tangent1End: CGPoint(x: x, y: y), tangent2End: CGPoint(x: fullWidthX, y: y), radius: CGFloat(radiusTopLeft))
        path.closeSubpath()
 */
        path.addRect(CGRect.init(x: 0, y: 0, width: 100, height: 200))
        
        context.addPath(path)
        context.strokePath()
        context.setFillColor(UIColor.red.cgColor)
        context.fillPath()
        context.setStrokeColor(UIColor.blue.cgColor)
        context.setLineWidth(10.0)
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        print("Rendered")
    }

    func getRadiusFactor(width: Int, height: Int, radiusTopLeft: Double, radiusTopRight: Double, radiusBottomRight: Double, radiusBottomLeft: Double) -> Double {
        let fT = Double(width) / (radiusTopLeft + radiusTopRight)
        let fR = Double(height) / (radiusTopRight + radiusBottomRight)
        let fB = Double(width) / (radiusBottomLeft + radiusBottomRight)
        let fL = Double(height) / (radiusTopLeft + radiusBottomLeft)
        print("fT : \(fT)")
        return min(1.0, Double(min(min(fT, fR), min(fB, fL))))
    }

}

