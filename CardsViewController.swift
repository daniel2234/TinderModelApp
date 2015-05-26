//
//  CardsViewController.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-25.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, SwipeViewDelegate{
    
    struct Card {
        let cardView:CardView
        let swipeView:SwipeView
    }
    
    //create the appearance of a stack, card from dynamic
    let frontCardTopMargin:CGFloat = 0
    let backCardTopMargin:CGFloat = 10

    @IBOutlet weak var cardStackView: UIView!

    var backCard:Card?
    var frontCard:Card?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardStackView.backgroundColor = UIColor.clearColor()
        
        backCard = createCard(backCardTopMargin)
        cardStackView.addSubview(backCard!.swipeView)

        frontCard = createCard(frontCardTopMargin)
        cardStackView.addSubview(frontCard!.swipeView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //created a helper function to get the size of the cards
    private func createCardFrame(topMargin:CGFloat) ->CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    private func createCard(topMargin:CGFloat) -> Card{
        let cardView = CardView()
        let swipeView = SwipeView(frame: createCardFrame(topMargin))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView)        
    }
    
    
    //swipeview delegate
    func swipeLeft() {
        println("Left")
        if let frontCard = frontCard{
            frontCard.swipeView.removeFromSuperview()
        }
    }

    func swipeRight() {
        println("Right")
        if let backCard = backCard{
            backCard.swipeView.removeFromSuperview()
        }
    }
}
