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
    
    //setup enum to track left or right
    
    enum Direction{
        case None
        case Left
        case Right
    }
    
    
    //lets us access the cardview instance
    private let card: CardView = CardView()
    
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
        addSubview(card)
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "wasDragged:"))
        card.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

    }
    
    
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
            resetViewPositionAndTransformation()
        default:
            println("Default triggered for UIPanGesture for GestureRecognizer")
            break
        }
        
    }
    
    private func resetViewPositionAndTransformation(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
            self.transform = CGAffineTransformMakeRotation(0)
        })
    }
}