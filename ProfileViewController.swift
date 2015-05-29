//
//  ProfileViewController.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-27.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.titleView = UIImageView(image: UIImage(named: "profile-header"))
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav-back-button"), style: UIBarButtonItemStyle.Plain, target: self, action: "goToCardViews:")
        navigationItem.setRightBarButtonItem(rightBarButtonItem, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = currentUser()?.name
        currentUser()?.getPhoto({ (image) -> () in
            self.imageView.layer.masksToBounds = true
            self.imageView.contentMode = .ScaleAspectFill
            self.imageView.image = image
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func goToCardViews(button: UIBarButtonItem){
        pageController.goToPreviousVC()
    }
    
    
    
}
