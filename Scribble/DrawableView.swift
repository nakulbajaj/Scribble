//
//  DrawableView.swift
//  Scribble
//
//  Created by Nakul Bajaj on 2/9/17.
//  Copyright © 2017 nakulbajaj. All rights reserved.
//

import UIKit

class DrawableView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let path=UIBezierPath()
    var previousPoint:CGPoint
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    override init(frame: CGRect) {
        previousPoint=CGPoint.zero
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        previousPoint=CGPoint.zero
        super.init(coder: aDecoder)!
        var panGestureRecognizer=UIPanGestureRecognizer(target: self, action: #selector(DrawableView.pan(_:)))
        panGestureRecognizer.maximumNumberOfTouches=1
        self.addGestureRecognizer(panGestureRecognizer)
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        SharingManager.sharedInstance.sharedColor.setStroke()
        //SharingManager.sharedInstance.sharedColor.setStroke()
        path.stroke()
        path.lineWidth = SharingManager.sharedInstance.sharedThickness
    }
    func pan(_ panGestureRecognizer:UIPanGestureRecognizer)->Void
    {
        let currentPoint=panGestureRecognizer.location(in: self)
        let midPoint=self.midPoint(previousPoint, p1: currentPoint)
        
        if panGestureRecognizer.state == .began
        {
            path.move(to: currentPoint)
        }
        else if panGestureRecognizer.state == .changed
        {
            path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
        }
        
        previousPoint=currentPoint
        self.setNeedsDisplay()
    }
    func midPoint(_ p0:CGPoint,p1:CGPoint)->CGPoint
    {
        let x=(p0.x+p1.x)/2
        let y=(p0.y+p1.y)/2
        return CGPoint(x: x, y: y)
    }
    


}
