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
        self.backgroundColor = UIColor.clearColor()
        addSubview(card)
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "wasDragged:"))
        
        originalPoint = center
        
        //do not want to use pre-defined constraints
        card.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        setConstraints()
    }
    
    
    func wasDragged(gestureRecognizer:UIPanGestureRecognizer){
        let distance = gestureRecognizer.translationInView(self)
        println("Distance x:\(distance.x) y:\(distance.y)")
        //meveytime we drag we are gong to the cahnge the center of the swipeview
        center = CGPointMake(originalPoint!.x + distance.x, originalPoint!.y + distance.y)
    }
    
    private func resetViewPositionAndTransformation(){
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.center = self.originalPoint!
        })
    }
    
    private func setConstraints(){
//        setting constraints to x
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0))
        //setting constraints to y
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0))
        //setting constraints to width
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0))
        //setting constraints to height 
        addConstraint(NSLayoutConstraint(item: card, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0))
        
    }
    
}