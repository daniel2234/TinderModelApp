//
//  CardsViewController.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-25.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    //create the appearance of a stack, card from dynamic
    let frontCardTopMargin:CGFloat = 0
    let backCardTopMargin:CGFloat = 10

    @IBOutlet weak var cardStackView: UIView!

    var backCard:SwipeView?
    var frontCard:SwipeView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backCard = SwipeView(frame: createCardFrame(backCardTopMargin))
        cardStackView.addSubview(backCard!)

        frontCard = SwipeView(frame: createCardFrame(frontCardTopMargin))
        cardStackView.addSubview(frontCard!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //created a helper function to get the size of the cards
    private func createCardFrame(topMargin:CGFloat) ->CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
}
