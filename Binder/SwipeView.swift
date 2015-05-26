//
//  SwipeView.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-25.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import Foundation
import UIKit

class SwipeView: UIView {
    
    //memory effiecency for delegate
    weak var delegate:SwipeViewDelegate?
    
    var innerView:UIView?{
        didSet{
            if let v = innerView{
                addSubview(v)
                v.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            }
        }
        
    }
    //setup enum to track left or right
    enum Direction{
        case None
        case Left
        case Right
    }
    
    
    //lets us access the cardview instance
//    private let card: CardView = CardView()
    
    //its going to store the original location of the card and it will help with reset the original point
    private var originalPoint:CGPoint?
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    init(){
        super.init(frame:CGRectZero)
        initialize()
    }
    
    private func initialize(){
        self.backgroundColor = UIColor.redColor()
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "wasDragged:"))


    }
    
    //dragged function
    func wasDragged(gestureRecognizer:UIPanGestureRecognizer){
        let distance = gestureRecognizer.translationInView(self)
        println("Distance x:\(distance.x) y:\(distance.y)")
        
        switch gestureRecognizer.state{
        case UIGestureRecognizerState.Began:
            originalPoint = center
        case UIGestureRecognizerState.Changed:
            //everytime we drag we are gong to the cahnge the center of the swipeview
            
        let rotationPercentage =  min(distance.x/(self.superview!.frame.width/2), 1)
        let rotationAngle = (CGFloat(2*M_PI/16) * rotationPercentage)

        //        transform = CGAffineTransformRotate(transform, rotationAngle)
        transform = CGAffineTransformMakeRotation(rotationAngle)
        
        center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
        
        case UIGestureRecognizerState.Ended:
            if abs(distance.x) < frame.width/4{
                resetViewPositionAndTransformation()
            } else{
                swipeDirection(distance.x > 0 ? .Right : .Left)
            }
        default:
            println("Default triggered for UIPanGesture for GestureRecognizer")
            break
        }
    }
    
    //track direction
    func swipeDirection(s: Direction){
        if s == .None{
            return
        }
        var parentWidth = superview!.frame.size.width
        if s == .Left{
            parentWidth *= -1
        }
        
        UIView.animateWithDuration(0.2, animations: {
        self.center.x = self.frame.origin.x + parentWidth
            
            }, completion: {
                success in
                if let d = self.delegate{
                    s == .Right ? d.swipeRight() : d.swipeLeft()
                }
                
        })
        
        //determine to animate to this to the animate left or right, we are going update the center of the swipeview
        UIView.animateWithDuration(0.2, animations: { () -> Void in
        })
    }
    
    private func resetViewPositionAndTransformation(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0)
        })
    }

}
//added a protocol
protocol SwipeViewDelegate:class{
    func swipeLeft()
    func swipeRight()
}