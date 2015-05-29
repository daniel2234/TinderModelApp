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
        let user:User
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
        
//        backCard = createCard(backCardTopMargin)
//        cardStackView.addSubview(backCard!.swipeView)
//
//        frontCard = createCard(frontCardTopMargin)
//        cardStackView.addSubview(frontCard!.swipeView)
        
        fetchUnViewedUsers{ returnedUsers in
                self.users = returnedUsers
                println(self.users)
                
                if let card = self.popCard(){
                    //frame for card is not set because it is a constant of 0
                    self.frontCard = card
                    self.cardStackView.addSubview(self.frontCard!.swipeView)
                }
            if let users = self.users{
                for user in users{
                        if let card = self.popCard(){
                            self.backCard = card
                            self.backCard!.swipeView.frame = self.createCardFrame(self.backCardTopMargin)
                            self.cardStackView.insertSubview(self.backCard!.swipeView, belowSubview: self.frontCard!.swipeView)
                        }
                    }
                }
            }
    }

    //setup left bar button item to transition to the next screen
    func goToProfile(button:UIBarButtonItem){
        pageController.goToPreviousVC()
    }
    
    //created a helper function to get the size of the cards
    private func createCardFrame(topMargin:CGFloat) ->CGRect{
        return CGRect(x: 0, y: topMargin, width: cardStackView.frame.width, height: cardStackView.frame.height)
    }
    
    private func createCard(user:User) -> Card{
        let cardView = CardView()
        cardView.name = user.name
        user.getPhoto({
            image in cardView.image = image
        })
        
        
        let swipeView = SwipeView(frame: createCardFrame(0))
        swipeView.delegate = self
        swipeView.innerView = cardView
        return Card(cardView: cardView, swipeView: swipeView, user:user)
    }
    
    
    private func popCard() -> Card?{
        if users != nil && users?.count > 0 {
            return createCard(users!.removeLast())
        }
        return nil
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
        if let frontCard = frontCard{
            frontCard.swipeView.removeFromSuperview()
        }
    }
}
