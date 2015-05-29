//
//  ViewController.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-24.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import UIKit


let pageController = ViewController(transitionStyle:UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options:nil)


class ViewController: UIPageViewController, UIPageViewControllerDataSource {

    //store instances of CardsNavController and ProfileNavController as constants to store them later
    let cardsVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CardsNavController") as! UIViewController
    let profilesVC: UIViewController! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileNavController") as! UIViewController
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        self.dataSource = self
//      self.view.addSubview(CardView(frame: CGRectMake(80.0, 80.0, 120.0, 200.0)))
//      self.view.addSubview(CardView(frame: CGRectMake(CGRectGetMidX(self.view.bounds) - 60.0, 80.0, 120.0, 200.0)))
//      which view controller do you want to show the user for now
        self.setViewControllers([cardsVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goToNextVC(){
    let nextVC = pageViewController(self, viewControllerAfterViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([nextVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    }
    func goToPreviousVC(){
    let previousVC = pageViewController(self, viewControllerBeforeViewController: viewControllers[0] as! UIViewController)!
        setViewControllers([previousVC], direction: UIPageViewControllerNavigationDirection.Reverse, animated: true, completion: nil)
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        switch viewController{
        case cardsVC:
            return profilesVC
        case profilesVC:
            return nil
        default:
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        switch viewController{
        case profilesVC:
            return cardsVC
        case cardsVC:
            return nil
        default:
            return nil
        }
    }
    

}

