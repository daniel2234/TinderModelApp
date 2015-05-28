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
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile", "user_about_me", "user_birthday","email"], block: { (user, error) -> Void in
            if user == nil{
                println("Facebook cancelled the login")
            }else if (user!.isNew){
                
                println("User signed up and login in to facebook")
                if (FBSDKAccessToken.currentAccessToken() != nil){
                    
                    // user is alredy logged in, do work and go to next view controller
                    println("Token available")
                    self.returnUserData(user)
                    
                    
                }else{
                    println("No Token")
                }
            }else{
                println("User logged through Facebook")
                if(FBSDKAccessToken.currentAccessToken() != nil){
                    println("token available")
                    self.returnUserData(user)
                }else{
                    println("NO token")
                }
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as? UIViewController
                self.presentViewController(vc!, animated: true, completion: nil)
            }
            
        })
        
    }

    
    
    
    func returnUserData(user:PFUser?){
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "/me?fields=picture,first_name,birthday,gender,email", parameters: nil)
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            if ((error) != nil){
                println("Error:\(error)")
            }else{
                
               var d = result as! NSDictionary
                user!["firstName"] = d["first_name"]
                user!["gender"] = d["gender"]
                user!["email"] = d["email"]
                
                var dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "mm/dd/yyyy"
                user!["birthday"] = dateFormatter.dateFromString(d["birthday"] as! String)
                
                //download the picture into Parse
                let pictureURL = ((d["picture"] as! NSDictionary)["data"] as! NSDictionary)["url"] as! String
                let url = NSURL(string: pictureURL)
                let request = NSURLRequest(URL: url!)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
                    let imageFile = PFFile(name: "ava.jpg", data: data)
                    user!["picture"] = imageFile
                    
                    user!.saveInBackgroundWithBlock({ (success, error) -> Void in
                        if success{
                            println("Saving Data in Parse")
                        }else{
                            println("Error Saving Data to Parse")
                        }
                    })
                })
                
            }
        }
    }
    
}
