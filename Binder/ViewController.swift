//
//  ViewController.swift
//  Binder
//
//  Created by Daniel Kwiatkowski on 2015-05-24.
//  Copyright (c) 2015 Daniel Kwiatkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(CardView(frame: CGRectMake(80.0, 80.0, 120.0, 200.0)))
//       self.view.addSubview(CardView(frame: CGRectMake(CGRectGetMidX(self.view.bounds) - 60.0, 80.0, 120.0, 200.0)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

