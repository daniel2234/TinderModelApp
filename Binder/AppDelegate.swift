//
//  AppDelegate.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-24.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import UIKit
import Parse
import Bolts
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("nOUbSjxviJchBTqmRTQ1noNZfthdVAhCHeuJDJwf",
            clientKey: "urpc7lE9tXNXVOB1p8YwrJq6w2xb95Xo7toP0imR")
        PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
        
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        //needed and instance of storyboard to present a view controller to help redirect
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        var initialViewController: UIViewController
        
        
        //PFUser.currentUser() is just a convenience method we get from Parse when a user already exists.
        if currentUser() != nil{
            
//            initialViewController = storyboard.instantiateViewControllerWithIdentifier("PageController") as! UIViewController
            
//            initialViewController = ViewController(transitionStyle:UIPageViewControllerTransitionStyle.Scroll,navigationOrientation:UIPageViewControllerNavigationOrientation.Horizontal, options:nil)
            initialViewController = pageController
            
        } else {
            initialViewController = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as! UIViewController
        }
        
        //this is to show where to start showing the dynamic view controller
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        
        
        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        //activates the the first time its launched
        FBSDKAppEvents.activateApp()
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        //logs out the user when app is terminated
        PFFacebookUtils.facebookLoginManager().logOut()
    
    }


}

