//
//  User.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-27.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import Foundation

//create a user struct
struct User{
    let id: String
    let name: String
    //let pictureURL: String
    
    //we do not want other files access this, only our backend should know about this
    private let pfUser: PFUser
    
    //nested function for asynchrous connection
    //supplying callback with data
    //wait until we write the callback ourselves
    func getPhoto(callback:(UIImage)->()){
        let imageFile = pfUser.objectForKey("picture") as! PFFile
        imageFile.getDataInBackgroundWithBlock { (data, error) -> Void in
            //test for data to is there is any.
            if let data = data{
                //unwrap optional to call and instance of the photo
                callback(UIImage(data: data)!)
            }
        }
        
    }
}

//returns user in this user instane
private func pfUserToUser(user:PFUser)-> User{
    return User(id: user.objectId!, name: user.objectForKey("firstName") as! String, pfUser: user)
}


func currentUser() -> User?{
    if let user = PFUser.currentUser(){
        return pfUserToUser(user)
    }
    return nil
}

// I rewrote things a bit referring more clearly to PFUser versus User. Also is it important to notice that objectForKey is objective-C. Writing user.objectForKey("firstName") coincides with user["firstName"] if I recall properly. Hence we must explain to the compiler which kind of variable they are: swift Strings. Also worth mentioning: user.objectForKey("picture") does not refer to the original NSDictionary or you would have had to index down farther. It does refer to the PFUser instance which fields can be found as column names in parse. Last method below should be User? instead of User.