//
//  LoginViewController.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-26.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func pressedFBLogin(sender: UIButton) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "user_about_me", "user_birthday"], block: { (user, error) -> Void in
            if user == nil{
                println("Facebook cancelled the login")
            }
            else if (user!.isNew){
                println("User signed up and login in to facebook")
            } else{
                println("User logged through Facebok")
            }
        })
        
    }

}
