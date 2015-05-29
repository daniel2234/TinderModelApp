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
    
    var users:[User]?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named:"BINDER"))
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToProfile:")
       navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardStackView.backgroundColor = UIColor.clearColor()
        
        backCard = createCard(backCardTopMargin)
        cardStackView.addSubview(backCard!.swipeView)

        frontCard = createCard(frontCardTopMargin)
        cardStackView.addSubview(frontCard!.swipeView)
        
        fetchUnViewedUsers(
            {
                returnedUsers in
                self.users = returnedUsers
                println(self.users)
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    //setup left bar button item to transition to the next screen
    func goToProfile(button:UIBarButtonItem){
        pageController.goToPreviousVC()
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
